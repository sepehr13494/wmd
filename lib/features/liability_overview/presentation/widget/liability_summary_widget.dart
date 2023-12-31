import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/as_of_date_widget.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/title_subtitle.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class LiabilitySummaryWidget extends AppStatelessWidget {
  const LiabilitySummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return BlocBuilder<SummeryWidgetCubit, MainDashboardState>(
        builder: (context, state) {
      if (state is MainDashboardNetWorthLoaded) {
        final liability = state.netWorthObj.liabilities;
        final date = (context.read<SummeryWidgetCubit>().dateTimeRange ??
                AppConstants.timeFilter(context).first)
            .key;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Builder(builder: (context) {
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
                                  appLocalizations
                                      .liabilities_label_yourBorrowings,
                                  style: textTheme.titleSmall
                                      ?.apply(fontSizeDelta: 1.28),
                                ),
                                SizedBox(height: responsiveHelper.bigger16Gap),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: PrivacyBlurWidget(
                                    child: Text(
                                      liability.currentValue
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    appLocalizations
                                        .liabilities_details_card_details,
                                    style: textTheme.titleSmall
                                        ?.apply(fontSizeDelta: 1.28),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '${appLocalizations.common_button_seeMore} >',
                                      style: textTheme.labelSmall!.apply(
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: responsiveHelper.bigger16Gap),
                              Wrap(
                                // showRow: !isMobile,
                                // columnCrossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  ExpandedIf(
                                    flex: 4,
                                    expanded: !isMobile,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            LiabilityInfoWidget(
                                              title: appLocalizations
                                                  .liabilities_label_totalMonthylPayment,
                                              content: liability
                                                  .newLiabilityValue
                                                  .convertMoney(
                                                      addDollar: true,
                                                      textDollar: true),
                                              value: liability.change == 0
                                                  ? null
                                                  : liability.change,
                                            ),
                                            LiabilityInfoWidget(
                                              title: appLocalizations
                                                  .liabilities_label_upcomingOutflow,
                                              content: liability
                                                  .newLiabilityCount
                                                  .convertMoney(
                                                      addDollar: true,
                                                      textDollar: true),
                                              desc: date,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24, width: 4),
                                  ExpandedIf(
                                    flex: 5,
                                    expanded: !isMobile,
                                    child: LiabilityInfoWidget(
                                      content: liability.itd.convertMoney(
                                          addDollar: true, textDollar: true),
                                      desc: date,
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
                AsOfDateWidget(shownDate: DateTime.now())
              ],
            );
          }),
        );
      }
      return const LoadingWidget();
    });
  }
}

class LiabilityInfoWidget extends AppStatelessWidget {
  final double? value;
  final String? title;
  final String content;
  final String? desc;
  const LiabilityInfoWidget({
    this.value,
    this.desc,
    required this.content,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: textTheme.bodyMedium),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrivacyBlurWidget(child: Text(content, style: textTheme.bodyLarge)),
            if (value != null)
              ChangeWidget(
                  number: value!, text: value!.toStringAsFixed(1) + '%'),
          ],
        ),
        if (desc != null) Text(desc!, style: textTheme.bodySmall),
      ],
    );
  }
}
