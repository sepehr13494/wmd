import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/get_allocation_entity.dart';

class CustomDashboardChartTooltip extends StatelessWidget {
  final GetAllocationEntity? selected;

  const CustomDashboardChartTooltip({Key? key, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
      final GetAllocationEntity getAllocationEntity = selected!;
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 200,
          decoration: Theme.of(context).tooltipTheme.decoration,
          child: Builder(builder: (context) {
            final appLocalizations = AppLocalizations.of(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CustomizableDateTime.graphDateV2(
                      CustomizableDateTime.stringToDate(
                          getAllocationEntity.name),
                      context),
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                eachTooltipItem(
                  appLocalizations.home_dashboardCharts_legendLabel_netWorth,
                  getAllocationEntity.netWorth.formatNumberWithDecimal(),
                ),
                eachTooltipItem(
                  appLocalizations.home_dashboardCharts_legendLabel_assets,
                  getAllocationEntity.asset.formatNumberWithDecimal(),
                ),
                eachTooltipItem(
                  appLocalizations.home_dashboardCharts_legendLabel_liability,
                  getAllocationEntity.liability.formatNumberWithDecimal(),
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
