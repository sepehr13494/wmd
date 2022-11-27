import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

import 'ytd_itd_widget.dart';

class OverViewCard extends AppStatelessWidget {
  const OverViewCard({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return BlocBuilder<MainDashboardCubit, MainDashboardState>(
  builder: (context, state) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
              color: textTheme.bodySmall!.color!.withOpacity(0.05)),
          padding: EdgeInsets.all(responsiveHelper.bigger24Gap),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RowOrColumn(
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              showRow: !isMobile,
              children: [
                ExpandedIf(
                  expanded: !isMobile,
                  child: Align(
                    alignment: isMobile ? AlignmentDirectional.centerStart : Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your holdings",
                          style: textTheme.titleSmall,
                        ),
                        SizedBox(height: responsiveHelper.bigger16Gap),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state is MainDashboardNetWorthLoaded ? state.netWorthObj.assets.currentValue.convertMoney(addDollar: true) : "...",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                !isMobile
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap),
                        width: 1,
                        height: 120,
                        color: Theme.of(context).dividerColor,
                      )
                    : const Divider(height: 48),
                ExpandedIf(
                  expanded: !isMobile,
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Net change",
                        style: textTheme.titleSmall,
                      ),
                      SizedBox(height: responsiveHelper.bigger16Gap),
                      RowOrColumn(
                        showRow: !isMobile,
                        children: [
                          ExpandedIf(
                            expanded: !isMobile,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last 365 days",
                                  style: textTheme.bodySmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$1,326,320",
                                      style: textTheme.bodyLarge,
                                    ),
                                    ChangeWidget(number: 8.03, text: "8.03%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24, width: 4),
                          ExpandedIf(
                            expanded: !isMobile,
                            child: YtdItdWidget(expand: !isMobile,ytd: 0,itd: 0),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "As of 17th Apr 2022, 10:22 a.m.",
            style: textTheme.bodySmall,
          ),
        )
      ],
    );
  },
);
  }
}
