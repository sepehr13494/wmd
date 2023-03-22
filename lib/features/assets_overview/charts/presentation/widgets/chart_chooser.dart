import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';

abstract class BarType{}
enum AssetsBarType implements BarType{
  barChart,
  areaChart,
  areaPercentage,
}

enum GeoBarType implements BarType{
  map,
  tree,
}

class AllChartType extends Equatable {
  final String name;
  final BarType barType;

  const AllChartType({
    required this.name,
    required this.barType,
  });

  static List<AllChartType> getAllTypes(BuildContext context, {bool isGeo = false}) {
    final appLocalizations = AppLocalizations.of(context);
    if(isGeo){
      return [
        AllChartType(name: appLocalizations.assets_charts_allocationCharts_treemapLabel, barType: GeoBarType.tree),
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_worldmapLabel,
            barType: GeoBarType.map),
      ];
    }else{
      return [
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_barChartLabel,
            barType: AssetsBarType.barChart),
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_areaChartLabel,
            barType: AssetsBarType.areaChart),
        AllChartType(name: appLocalizations.assets_charts_allocationCharts_areaChartLabel+"%", barType: AssetsBarType.areaPercentage),
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
  const ChartChooserWidget({Key? key, required this.isGeo,this.show=true}) : super(key: key);

  @override
  AppState<ChartChooserWidget> createState() => _ChartChooserWidgetState();
}

class _ChartChooserWidgetState extends AppState<ChartChooserWidget> {
  late ChartChooserManager provider;
  @override
  void didChangeDependencies() {
    if(widget.isGeo){
      provider = context.watch<GeoChartChooserManager>();
    }else{
      provider = context.watch<AssetChartChooserManager>();
    }
    if (provider.state == null) {
      provider.changeChart(AllChartType.getAllTypes(context,isGeo: widget.isGeo).first);
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
            final items = AllChartType.getAllTypes(context,isGeo: widget.isGeo);
            return DropdownButtonHideUnderline(
              child: DropdownButton<AllChartType>(
                  isDense: true,
                  items: List.generate(items.length, (index) {
                    return DropdownMenuItem<AllChartType>(
                      value: items[index],
                      child: Text(
                        items[index].name,
                        style: textTheme.bodyMedium!
                            .apply(color: Theme.of(context).primaryColor),
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
