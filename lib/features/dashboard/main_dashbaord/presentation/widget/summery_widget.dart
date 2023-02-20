import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/entities/net_worth_entity.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summart_time_filter.dart';

class SummeryWidget extends StatefulWidget {
  final NetWorthEntity netWorthEntity;
  const SummeryWidget({Key? key, required this.netWorthEntity})
      : super(key: key);

  @override
  AppState<SummeryWidget> createState() => _SummeryWidgetState();
}

class _SummeryWidgetState extends AppState<SummeryWidget> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final String date = (context.watch<MainDashboardCubit>().dateTimeRange ??
            AppConstants.timeFilter(context).first)
        .key;
    print("widget.netWorthEntity.assets");
    print(widget.netWorthEntity.assets);
    final assetText = appLocalizations.home_widget_summaryCard_tooltip_assets
        .replaceAll(
            "{{count}}", widget.netWorthEntity.assets.newAssetCount.toInt().toString())
        .replaceAll(
            "{{change}}",
            widget.netWorthEntity.assets.newAssetValue
                .convertMoney()
                .toString());
    final liabilitiesText = appLocalizations
        .home_widget_summaryCard_tooltip_liabilities
        .replaceAll("{{count}}",
            widget.netWorthEntity.liabilities.newLiabilityCount.toInt().toString())
        .replaceAll(
            "{{change}}",
            widget.netWorthEntity.liabilities.newLiabilityValue
                .convertMoney()
                .toString());
    final List items = [
      [
        appLocalizations.home_label_totalNetWorth,
        widget.netWorthEntity.totalNetWorth.currentValue,
        date,
        widget.netWorthEntity.totalNetWorth.change,
        "$assetText\n$liabilitiesText",
      ],
      [
        appLocalizations.home_label_assets,
        widget.netWorthEntity.assets.currentValue,
        date,
        widget.netWorthEntity.assets.change,
        assetText,
      ],
      [
        appLocalizations.home_label_liabilities,
        widget.netWorthEntity.liabilities.currentValue,
        date,
        widget.netWorthEntity.liabilities.change,
        liabilitiesText,
      ],
    ];
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Column(
      children: [
        const SummaryTimeFilter(key: Key('SummaryWidget')),
        const SizedBox(height: 12),
        RowOrColumn(
          showRow: !isMobile,
          children: List.generate(items.length, (index) {
            final item = items[index];
            return ExpandedIf(
              expanded: !isMobile,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWithInfo(
                        title: item[0],
                        hasInfo: true,
                        tooltipText: item[4],
                        icon: Icons.info,
                      ),
                      const SizedBox(height: 8),
                      Text((item[1] as double).convertMoney(addDollar: true),
                          style: textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Builder(builder: (context) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Text(
                                item[2],
                                style: textTheme.bodySmall!.apply(
                                    color: AppColors.dashBoardGreyTextColor),
                              ),
                              const SizedBox(width: 8),
                              ChangeWidget(
                                  number: item[3],
                                  text: (item[3] as double)
                                      .convertMoney(addDollar: true))
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
