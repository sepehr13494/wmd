import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/bar_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/line_chart.dart';

class NetWorthBaseChart extends StatefulWidget {
  const NetWorthBaseChart({Key? key}) : super(key: key);

  @override
  AppState<NetWorthBaseChart> createState() => _NetWorthBaseChartState();
}

class _NetWorthBaseChartState extends AppState<NetWorthBaseChart> {

  bool barChart = false;

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Net Worth", style: TextStyle(fontSize: 18)),
                Builder(
                  builder: (context) {
                    final items = ["Bar Chart","Line Chart"];
                    return DropdownButton<String>(items: List.generate(2, (index) {
                      return DropdownMenuItem<String>(value: items[index],child: Text(items[index]),);
                    }), onChanged: ((value) {
                      if(value == "Bar Chart"){
                        setState(() {
                          barChart = true;
                        });
                      }else{
                        setState(() {
                          barChart = false;
                        });
                      }
                    }),value: barChart ? "Bar Chart" : "Line Chart");
                  }
                )
              ],
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio:
              ResponsiveHelper(context: context).isMobile ? 1.6 : 2.2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: barChart ? BarChartMainDashboard() : LineChartSample2(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
