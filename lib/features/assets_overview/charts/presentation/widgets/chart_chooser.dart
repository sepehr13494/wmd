import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum BarType {
  barChart,
  lineChart,
  areaChart,
  treeChart,
}

class AllBarType {
  final String name;
  final BarType barType;

  AllBarType({
    required this.name,
    required this.barType,
  });

  static List<AllBarType> getAllTypes(BuildContext context){
    final appLocalizations = AppLocalizations.of(context);
    return [
      AllBarType(name: appLocalizations.assets_charts_allocationCharts_barChartLabel, barType: BarType.barChart),
      AllBarType(name: appLocalizations.assets_charts_allocationCharts_areaChartLabel, barType: BarType.areaChart),
      AllBarType(name: appLocalizations.assets_charts_allocationCharts_barChartLabel, barType: BarType.barChart),
    ];
  }
}

class ChartChooserWidget extends StatefulWidget {
  final Function(AllBarType allBarType) onChanged;

  const ChartChooserWidget({Key? key, required this.onChanged})
      : super(key: key);

  @override
  AppState<ChartChooserWidget> createState() => _ChartChooserWidgetState();
}

class _ChartChooserWidgetState extends AppState<ChartChooserWidget> {

  late AllBarType allBarType;

  @override
  void initState() {
    allBarType = AllBarType.getAllTypes(context).first;
    super.initState();
  }
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.bar_chart,
          size: 15,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Builder(builder: (context) {
          final items = AllBarType.getAllTypes(context);
          return DropdownButtonHideUnderline(
            child: DropdownButton<AllBarType>(
                items: List.generate(2, (index) {
                  return DropdownMenuItem<AllBarType>(
                    value: items[index],
                    child: Text(
                      items[index].name,
                      style: textTheme.bodyMedium!
                          .apply(color: Theme.of(context).primaryColor),
                    ),
                  );
                }),
                onChanged: ((value) {
                  if(value != null){
                    setState(() {
                      allBarType = value;
                    });
                    widget.onChanged(value);
                  }
                }),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),
                value: allBarType
            ),
          );
        })
      ],
    );
  }
}
