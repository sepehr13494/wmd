import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/extentions/round_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/as_of_date_widget.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

import 'ytd_itd_widget.dart';

class OverViewCard extends AppStatelessWidget {
  const OverViewCard({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return BlocBuilder<SummeryWidgetCubit, MainDashboardState>(
      builder: (context, state) {
        if (state is MainDashboardNetWorthLoaded) {
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
                          alignment: isMobile
                              ? AlignmentDirectional.centerStart
                              : Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.assets_label_yourHoldings,
                                style: textTheme.titleSmall
                                    ?.apply(fontSizeDelta: 1.28),
                              ),
                              SizedBox(height: responsiveHelper.bigger16Gap),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: PrivacyBlurWidget(
                                  child: Text(
                                    state.netWorthObj.assets.currentValue
                                        .convertMoney(addDollar: true),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !isMobile
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: responsiveHelper.bigger16Gap),
                              width: 1,
                              height: 120,
                              color: Theme.of(context).dividerColor,
                              child: Divider(
                                thickness: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                            )
                          : Divider(
                              thickness: 1,
                              color: Theme.of(context).dividerColor,
                              height: 48,
                            ),
                      ExpandedIf(
                        expanded: !isMobile,
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations.assets_label_netChange,
                              style: textTheme.titleSmall
                                  ?.apply(fontSizeDelta: 1.28),
                            ),
                            SizedBox(height: responsiveHelper.bigger16Gap),
                            RowOrColumn(
                              showRow: !isMobile,
                              children: [
                                ExpandedIf(
                                  flex: 4,
                                  expanded: !isMobile,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (context
                                                    .read<SummeryWidgetCubit>()
                                                    .dateTimeRange ??
                                                AppConstants.timeFilter(context)
                                                    .first)
                                            .key,
                                        style: textTheme.bodySmall,
                                      ),
                                      Row(
                                        children: [
                                          PrivacyBlurWidget(
                                            child: Text(
                                              state.netWorthObj.assets.change
                                                  .convertMoney(
                                                      addDollar: true),
                                              style: textTheme.bodyLarge,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          ChangeWidget(
                                              number: state.netWorthObj.assets
                                                  .changePercentage,
                                              text:
                                                  "${state.netWorthObj.assets.changePercentage.toStringFixedZeroless()}%"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24, width: 4),
                                ExpandedIf(
                                  flex: 5,
                                  expanded: !isMobile,
                                  child: YtdItdWidget(
                                    expand: !isMobile,
                                    ytd: state.netWorthObj.assets.ytd,
                                    itd: state.netWorthObj.assets.itd,
                                  ),
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
              AsOfDateWidget(
                  shownDate: DateTime.parse(state.netWorthObj.lastUpdated))
            ],
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
