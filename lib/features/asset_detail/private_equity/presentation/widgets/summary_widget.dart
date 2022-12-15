import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/current_date_widget.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/net_change_widget.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/portfolio_contribution_widget.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/your_holdings_widget.dart';
import 'package:wmd/features/asset_detail/private_equity/domain/entity/private_equity_entity.dart';

class PrivateEquitySummaryWidget extends AppStatelessWidget {
  final PrivateEquityEntity privateEquityEntity;
  const PrivateEquitySummaryWidget(this.privateEquityEntity, {Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final String currencySymbol =
        AppConstants.getCurrencySymbolByCode(privateEquityEntity.currencyCode);
    final lineColor = Theme.of(context).dividerColor;
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
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
              showRow: !isMobile,
              children: [
                ExpandedIf(
                  expanded: !isMobile,
                  child: YourHoldingsWidget(
                    holdings: privateEquityEntity.holdings,
                    currencyCode: privateEquityEntity.currencyCode,
                  ),
                ),
                !isMobile
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: responsiveHelper.bigger16Gap),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ExpandedIf(
                            expanded: !isMobile,
                            child: const NetChangeWidget(),
                          ),
                          ExpandedIf(
                            expanded: !isMobile,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "YTD",
                                  style: textTheme.bodySmall,
                                ),
                                const ChangeWidget(number: 60, text: "60.0%"),
                              ],
                            ),
                          ),
                          ExpandedIf(
                            expanded: !isMobile,
                            child: Column(
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
                                const ChangeWidget(
                                    number: 12.12, text: "12.12%"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpandedIf(
                        expanded: !isMobile,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: PortfolioContributionWidget(
                              portfolioContribution:
                                  privateEquityEntity.portfolioContribution,
                              holdings: privateEquityEntity.holdings,
                              currencyCode: privateEquityEntity.currencyCode),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          const CurrentDateWidget(),
        ],
      ),
    );
  }
}
