import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';

enum BarType {
  barChart,
  areaChart,
  treeChart,
}

class AllChartType extends Equatable {
  final String name;
  final BarType barType;

  const AllChartType({
    required this.name,
    required this.barType,
  });

  static List<AllChartType> getAllTypes(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return [
      AllChartType(
          name: appLocalizations.assets_charts_allocationCharts_barChartLabel,
          barType: BarType.barChart),
      AllChartType(
          name: appLocalizations.assets_charts_allocationCharts_areaChartLabel,
          barType: BarType.areaChart),
      AllChartType(name: "tree chart", barType: BarType.treeChart),
    ];
  }

  @override
  List<Object?> get props => [
        name,
        barType,
      ];
}

class ChartChooserWidget extends StatefulWidget {
  const ChartChooserWidget({Key? key}) : super(key: key);

  @override
  AppState<ChartChooserWidget> createState() => _ChartChooserWidgetState();
}

class _ChartChooserWidgetState extends AppState<ChartChooserWidget> {
  @override
  void didChangeDependencies() {
    final provider = context.read<ChartChooserManager>();
    if (provider.state == null) {
      provider.changeChart(AllChartType.getAllTypes(context).first);
    }
    super.didChangeDependencies();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
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
          final items = AllChartType.getAllTypes(context);
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
                    context.read<ChartChooserManager>().changeChart(value);
                  }
                }),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),
                value: context.watch<ChartChooserManager>().state),
          );
        })
      ],
    );
  }
}
