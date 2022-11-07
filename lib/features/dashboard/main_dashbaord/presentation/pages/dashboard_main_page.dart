import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/line_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/pie_chart_sample.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/random_map.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summery_widget.dart';

class DashboardMainPage extends AppStatelessWidget {
  const DashboardMainPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: WidthLimiterWidget(
        width: 700,
        child: SingleChildScrollView(
          child: Theme(
            data: appTheme.copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: appTheme.outlinedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all(Size(0, 48))),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: appTheme.outlinedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all(Size(0, 48))),
                ),
                iconTheme:
                    appTheme.iconTheme.copyWith(color: appTheme.primaryColor)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Wealth Overview", style: textTheme.headlineSmall),
                    const Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          height: 32,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  const Icon(Icons.filter_alt, size: 15),
                                  isMobile
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            const SizedBox(width: 8),
                                            Text("Filter"),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  const Icon(Icons.add_circle, size: 15),
                                  isMobile
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            const SizedBox(width: 8),
                                            Text("Add"),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SummeryWidget(),
                LineChartSample2(),
                RowOrColumn(
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  showRow: !isMobile,
                  children: [
                    ExpandedIf(
                        expanded: !isMobile, child: RandomWorldMapGenrator()),
                    ExpandedIf(expanded: !isMobile, child: PieChartSample2()),
                  ],
                ),
              ]
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: e))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
