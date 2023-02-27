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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CustomizableDateTime.miniDateWithYear(getChartEntity.date),
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                getChartEntity.bankAccount != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Bank Account".replaceAll(" ", ""),
                  ),
                  getChartEntity.bankAccount.formatNumberWithDecimal(),
                )
                    : const SizedBox(),
                getChartEntity.privateEquity != 0
                    ?eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Private Equity".replaceAll(" ", ""),
                  ),
                  getChartEntity.privateEquity.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.privateDebt != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Private Debt".replaceAll(" ", ""),
                  ),
                  getChartEntity.privateDebt.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.realEstate != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Real Estate".replaceAll(" ", ""),
                  ),
                  getChartEntity.realEstate.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.listedAssetEquity != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetEquity.replaceAll(" ", ""),
                  ),
                  getChartEntity.listedAssetEquity.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.listedAssetFixedIncome != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetFixedIncome.replaceAll(" ", ""),
                  ),
                  getChartEntity.listedAssetFixedIncome.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.listedAssetOther != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetOther.replaceAll(" ", ""),
                  ),
                  getChartEntity.listedAssetOther.formatNumberWithDecimal(),
                ): const SizedBox(),
                getChartEntity.others != 0
                    ? eachTooltipItem(
                  AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Other Assets".replaceAll(" ", ""),
                  ),
                  getChartEntity.others.formatNumberWithDecimal(),
                ): const SizedBox(),
                eachTooltipItem(
                  "Total",
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
