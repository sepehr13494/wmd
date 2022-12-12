import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';

class ListedAssetSummaryWidget extends AppStatelessWidget {
  final ListedAssetEntity listedAssetEntity;
  const ListedAssetSummaryWidget(this.listedAssetEntity, {Key? key})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final String currencySymbol =
        AppConstants.getCurrencySymbolByCode(listedAssetEntity.currencyCode);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your holdings',
                        style: textTheme.titleSmall,
                      ),
                      SizedBox(height: responsiveHelper.bigger16Gap),
                      Text(
                        currencySymbol +
                            (listedAssetEntity.totalCost * 1.5)
                                .toInt()
                                .toString(),
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
                        children: [
                          Text(
                            "Net change",
                            style: textTheme.titleSmall,
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     'See more >',
                          //     style: textTheme.labelSmall!.apply(
                          //         color: Theme.of(context).primaryColor,
                          //         decoration: TextDecoration.underline),
                          //   ),
                          // )
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
                                Text(
                                  currencySymbol + '5000'.toString(),
                                  style: textTheme.bodyLarge,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Portfolio contribution",
                                style: textTheme.bodySmall,
                              ),
                              Builder(builder: (context) {
                                final double portfolioPercentage =
                                    listedAssetEntity.portfolioContribution *
                                        100;
                                return Text(
                                  "$portfolioPercentage% of $currencySymbol${listedAssetEntity.totalCost}",
                                  style: textTheme.bodyLarge,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
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
