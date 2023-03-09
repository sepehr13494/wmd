import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import '../../domain/entities/get_chart_entity.dart';

class ChartCustomTooltip extends StatelessWidget {
  final GetChartEntity? selected;

  const ChartCustomTooltip({Key? key, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget eachTooltipItem(String title, String value) {
      final textTheme = Theme.of(context).textTheme;
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: textTheme.bodyMedium!.apply(color: AppColors.chartColor),
          ),
        ],
      );
    }

    if (selected != null) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 250,
          decoration: Theme.of(context).tooltipTheme.decoration,
          child: Builder(builder: (context) {
            final textTheme = Theme.of(context).textTheme;
            final getChartEntity = selected!;
            final double sum = getChartEntity.privateEquity +
                getChartEntity.realEstate +
                getChartEntity.privateDebt +
                getChartEntity.others +
                getChartEntity.bankAccount +
                getChartEntity.listedAssetFixedIncome +
                getChartEntity.listedAssetEquity;
            final appLocalizations = AppLocalizations.of(context);
            final items = [
              [
                getChartEntity.bankAccount,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  "Bank Account".replaceAll(" ", ""),
                ),
                getChartEntity.bankAccount,
              ],
              [
                getChartEntity.privateEquity,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  "Private Equity".replaceAll(" ", ""),
                ),
                getChartEntity.privateEquity,
              ],
              [
                getChartEntity.privateDebt,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  "Private Debt".replaceAll(" ", ""),
                ),
                getChartEntity.privateDebt,
              ],
              [
                getChartEntity.realEstate,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  "Real Estate".replaceAll(" ", ""),
                ),
                getChartEntity.realEstate,
              ],
              [
                getChartEntity.listedAssetEquity,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  AssetTypes.listedAssetEquity.replaceAll(" ", ""),
                ),
                getChartEntity.listedAssetEquity,
              ],
              [
                getChartEntity.listedAssetFixedIncome,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  AssetTypes.listedAssetFixedIncome.replaceAll(" ", ""),
                ),
                getChartEntity.listedAssetFixedIncome,
              ],
              [
                getChartEntity.listedAssetOther,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  AssetTypes.listedAssetOther.replaceAll(" ", ""),
                ),
                getChartEntity.listedAssetOther,
              ],
              [
                getChartEntity.others,
                AssetsOverviewChartsColors.getAssetType(
                  appLocalizations,
                  "Other Assets".replaceAll(" ", ""),
                ),
                getChartEntity.others,
              ],
            ];
            items.sort(
              (a, b) {
                return ((b[2] as double) - (a[2] as double)).toInt();
              },
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CustomizableDateTime.graphDateV2(
                      CustomizableDateTime.stringToDate(getChartEntity.date),
                      context),
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  return item[0] != 0
                      ? eachTooltipItem(
                          item[1].toString(),
                          (item[2] as double).formatNumberWithDecimal(),
                        )
                      : const SizedBox();
                }),
                eachTooltipItem(
                  appLocalizations
                      .assets_charts_allocationCharts_legendLabel_total,
                  sum.formatNumberWithDecimal(),
                )
              ],
            );
          }),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
