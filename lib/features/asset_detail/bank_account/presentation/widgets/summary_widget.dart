import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/current_date_widget.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/net_change_widget.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/portfolio_contribution_widget.dart';

class BankAccountSummaryWidget extends AppStatelessWidget {
  final BankAccountEntity bankAccountEntity;
  const BankAccountSummaryWidget(this.bankAccountEntity, {Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final String currencySymbol =
        AppConstants.getCurrencySymbolByCode(bankAccountEntity.currencyCode);
    final lineColor = Theme.of(context).dividerColor;
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    // isMobile = false;
    final gap = responsiveHelper.bigger24Gap;
    return Container(
      // padding: EdgeInsets.all(responsiveHelper.bigger24Gap),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance',
                        style: textTheme.titleSmall,
                      ),
                      SizedBox(height: responsiveHelper.bigger16Gap),
                      Text(
                        currencySymbol +
                            bankAccountEntity.holdings.toInt().toString(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w300),
                      ),
                    ],
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
                            child: PortfolioContributionWidget(
                                portfolioContribution:
                                    bankAccountEntity.portfolioContribution,
                                holdings: bankAccountEntity.holdings,
                                currencyCode: bankAccountEntity.currencyCode),
                          ),
                        ],
                      )
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
