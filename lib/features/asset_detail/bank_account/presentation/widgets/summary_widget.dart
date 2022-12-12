import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';

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
                      if (bankAccountEntity.currentBalance != null)
                        Text(
                          currencySymbol +
                              bankAccountEntity.currentBalance!
                                  .toInt()
                                  .toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w300),
                        ),
                      Text(bankAccountEntity.type!),
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
                        children: [
                          Text(
                            "Net change",
                            style: textTheme.titleSmall,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See more >',
                              style: textTheme.labelSmall!.apply(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpandedIf(
                            expanded: !isMobile,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last 30 days",
                                  style: textTheme.bodySmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$1,326,320",
                                      style: textTheme.bodyLarge,
                                    ),
                                    const ChangeWidget(
                                        number: 8.03, text: "8.03%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ExpandedIf(
                            expanded: !isMobile,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Portfolio contribution",
                                  style: textTheme.bodySmall,
                                ),
                                Text(
                                  "2.76% of \$8,676,200",
                                  style: textTheme.bodyLarge,
                                ),
                              ],
                            ),
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "As of 17th Apr 2022, 10:22 a.m.",
                style: textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
