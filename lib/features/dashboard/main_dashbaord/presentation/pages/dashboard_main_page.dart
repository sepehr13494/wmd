import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/line_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/filter_add_widget.dart';
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
      body: BlocBuilder<MainDashboardCubit, MainDashboardState>(
        builder: BlocHelper.defaultBlocBuilder(builder: (context, state) {
          return WidthLimiterWidget(
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
                    filter_add_part(),
                    const SizedBox(height: 12),
                    SummeryWidget(),
                    LineChartSample2(),
                    RowOrColumn(
                      rowCrossAxisAlignment: CrossAxisAlignment.start,
                      showRow: !isMobile,
                      children: [
                        ExpandedIf(
                            expanded: !isMobile,
                            child: RandomWorldMapGenrator()),
                        ExpandedIf(
                            expanded: !isMobile, child: PieChartSample2()),
                      ],
                    ),
                  ]
                      .map((e) =>
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: e))
                      .toList(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
