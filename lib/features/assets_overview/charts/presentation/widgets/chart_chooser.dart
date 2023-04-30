import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';

abstract class BarType {}

enum AssetsBarType implements BarType {
  barChart,
  areaChart,
  areaPercentage,
  tree,
}

enum GeoBarType implements BarType {
  map,
  tree,
}

class AllChartType extends Equatable {
  final String name;
  final BarType barType;
  final String image;

  const AllChartType({
    required this.name,
    required this.barType,
    required this.image,
  });

  static List<AllChartType> getAllTypes(BuildContext context,
      {bool isGeo = false}) {
    final appLocalizations = AppLocalizations.of(context);
    if (isGeo) {
      return [
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_worldmapLabel,
            barType: GeoBarType.map,
            image: "assets/images/map_chart.png"),
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_treemapLabel,
            barType: GeoBarType.tree,
            image: "assets/images/tree_chart.png"),
      ];
    } else {
      return [
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_barChartLabel,
            barType: AssetsBarType.barChart,
            image: "assets/images/bar_chart.png"),
        AllChartType(
            name:
                appLocalizations.assets_charts_allocationCharts_areaChartLabel,
            barType: AssetsBarType.areaChart,
            image: "assets/images/area_chart.png"),
        AllChartType(
            name:
                "%${appLocalizations.assets_charts_allocationCharts_areaChartLabel}",
            barType: AssetsBarType.areaPercentage,
            image: "assets/images/area_percentage.png"),
        AllChartType(
            name:
            appLocalizations.assets_charts_allocationCharts_treemapLabel,
            barType: AssetsBarType.tree,
            image: "assets/images/tree_chart.png"),
      ];
    }
  }

  @override
  List<Object?> get props => [
        barType,
      ];
}

class ChartChooserWidget extends StatefulWidget {
  final bool isGeo;
  final bool show;

  const ChartChooserWidget({Key? key, required this.isGeo, this.show = true})
      : super(key: key);

  @override
  AppState<ChartChooserWidget> createState() => _ChartChooserWidgetState();
}

class _ChartChooserWidgetState extends AppState<ChartChooserWidget> {
  late ChartChooserManager provider;

  @override
  void didChangeDependencies() {
    if (widget.isGeo) {
      provider = context.watch<GeoChartChooserManager>();
    } else {
      provider = context.watch<AssetChartChooserManager>();
    }
    if (provider.state == null) {
      provider.changeChart(
          AllChartType.getAllTypes(context, isGeo: widget.isGeo).first);
    }
    super.didChangeDependencies();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    if (widget.show) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          Icon(
            Icons.bar_chart,
            size: 15,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Builder(builder: (context) {
            final items =
                AllChartType.getAllTypes(context, isGeo: widget.isGeo);
            return DropdownButtonHideUnderline(
              child: DropdownButton<AllChartType>(
                menuMaxHeight: 500,
                  itemHeight: 120,
                  selectedItemBuilder: (context) => items
                      .map((e) => Text(
                            e.name,
                            style: textTheme.bodyMedium!
                                .apply(color: Theme.of(context).primaryColor),
                          ))
                      .toList(),
                  isDense: true,
                  items: List.generate(items.length, (index) {
                    return DropdownMenuItem<AllChartType>(
                      value: items[index],
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Theme.of(context).cardColor)),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(items[index].image,
                                  width: 40, height: 40),
                              const SizedBox(height: 4),
                              Text(
                                items[index].name,
                                style: textTheme.bodyMedium!
                                    .apply(color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  onChanged: ((value) {
                    if (value != null) {
                      provider.changeChart(value);
                    }
                  }),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                  value: provider.state),
            );
          })
        ],
      );
    }
    return const SizedBox();
  }
}
