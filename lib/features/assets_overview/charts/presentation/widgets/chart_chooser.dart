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
  treeChart,
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
        AllChartType(
            name: appLocalizations.assets_charts_tabs_geography,
            barType: GeoBarType.map),
        AllChartType(name: "tree chart", barType: GeoBarType.tree),
      ];
    }else{
      return [
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_barChartLabel,
            barType: AssetsBarType.barChart),
        AllChartType(
            name: appLocalizations.assets_charts_allocationCharts_areaChartLabel,
            barType: AssetsBarType.areaChart),
        AllChartType(name: "tree chart", barType: AssetsBarType.treeChart),
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
  const ChartChooserWidget({Key? key, required this.isGeo}) : super(key: key);

  @override
  AppState<ChartChooserWidget> createState() => _ChartChooserWidgetState();
}

class _ChartChooserWidgetState extends AppState<ChartChooserWidget> {
  late ChartChooserManager provider;
  @override
  void didChangeDependencies() {
    if(widget.isGeo){
      provider = context.read<GetChartChooserManager>();
    }else{
      provider = context.read<ChartChooserManager>();
    }
    if (provider.state == null) {
      provider.changeChart(AllChartType.getAllTypes(context,isGeo: widget.isGeo).first);
    }
    super.didChangeDependencies();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    if (AppConstants.publicMvp2Items) {
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
