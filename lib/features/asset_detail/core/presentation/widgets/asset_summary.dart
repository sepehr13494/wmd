import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/asset_summary_entity.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/see_more_popup.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'as_of_date_widget.dart';
import 'net_change_widget.dart';
import 'portfolio_contribution_widget.dart';
import 'your_holdings_widget.dart';

class AsssetSummary extends AppStatelessWidget {
  final AssetSummaryEntitiy summary;
  final void Function()? onEdit;
  final Widget? child;
  final int days;
  const AsssetSummary({
    required this.summary,
    required this.days,
    this.onEdit,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(summary.assetName, style: textTheme.headlineSmall),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (summary.assetClassName != null) Text(summary.assetClassName),
              if (onEdit != null)
                InkWell(
                  onTap: () {
                    onEdit!();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2))),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        appLocalizations.common_button_editDetails,
                        style: textTheme.labelMedium!
                            .apply(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (child != null) child!,
          SummaryCardWidget(
            holdings: summary.totalAssetsAmount,
            days: days,
            netChange: summary.netChange,
            portfolioContribution: summary.dealContribution,
            asOfDate: summary.date,
          )
        ],
      ),
    );
  }
}

class SummaryCardWidget extends AppStatelessWidget {
  final double holdings;
  final int days;
  final double netChange;
  final double portfolioContribution;
  final DateTime? asOfDate;
  const SummaryCardWidget({
    required this.holdings,
    required this.days,
    required this.netChange,
    required this.portfolioContribution,
    this.asOfDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final lineColor = Theme.of(context).dividerColor;
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    // isMobile = true;
    final gap = responsiveHelper.bigger24Gap;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(color: lineColor),
          borderRadius: BorderRadius.circular(8),
          color: textTheme.bodySmall!.color!.withOpacity(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: gap, top: gap, right: gap),
            child: RowOrColumn(
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.start,
              showRow: !isMobile,
              children: [
                YourHoldingsWidget(holdings: holdings),
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
                  child: Column(
                    children: [
                      if (!isMobile)
                        _buildHeader(appLocalizations, textTheme, context),
                      RowOrColumn(
                        showRow: !isMobile,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        rowCrossAxisAlignment: CrossAxisAlignment.end,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isMobile)
                            Column(
                              children: [
                                _buildHeader(
                                    appLocalizations, textTheme, context),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: buildChildren(context, textTheme),
                                ),
                              ],
                            ),
                          if (!isMobile) ...buildChildren(context, textTheme),
                          Padding(
                            padding: isMobile
                                ? const EdgeInsets.symmetric(vertical: 12)
                                : const EdgeInsets.symmetric(vertical: 0),
                            child: Builder(builder: (context) {
                              if ((context.read<MainDashboardCubit>().state
                                  is MainDashboardNetWorthLoaded)) {
                                return PortfolioContributionWidget(
                                    portfolioContribution:
                                        portfolioContribution,
                                    netWorth: (context
                                                .read<MainDashboardCubit>()
                                                .state
                                            as MainDashboardNetWorthLoaded)
                                        .netWorthObj
                                        .totalNetWorth
                                        .currentValue);
                              }
                              return const SizedBox.shrink();
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isMobile ? const SizedBox(height: 16) : const SizedBox(),
          if (asOfDate != null) AsOfDateWidget(shownDate: asOfDate!),
        ],
      ),
    );
  }

  Row _buildHeader(AppLocalizations appLocalizations, TextTheme textTheme,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLocalizations.assets_label_netChange,
          style: textTheme.titleSmall,
        ),
        TextButton(
          onPressed: () {
            showSeeMoreModal(context: context, child: Text('data'));
          },
          child: Text(
            '${appLocalizations.common_button_seeMore} >',
            style: textTheme.labelSmall!.apply(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  List<Widget> buildChildren(context, textTheme) {
    return [
      NetChangeWidget(
        days: days,
        change: netChange,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "YTD",
                style: textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
                size: 14,
              )
            ],
          ),
          const ChangeWidget(number: 60, text: "60.0%"),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ITD",
                style: textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
                size: 14,
              )
            ],
          ),
          const ChangeWidget(number: 12.12, text: "12.12%"),
        ],
      ),
    ];
  }
}
