import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';
import 'package:wmd/core/presentation/widgets/tooltip_bank_exception.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/entities/net_worth_entity.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summart_time_filter.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';

class SummeryWidget extends StatefulWidget {
  final NetWorthEntity netWorthEntity;
  final bool isBankNotEmpty;
  const SummeryWidget(
      {Key? key, required this.netWorthEntity, this.isBankNotEmpty = false})
      : super(key: key);

  @override
  AppState<SummeryWidget> createState() => _SummeryWidgetState();
}

class _SummeryWidgetState extends AppState<SummeryWidget> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    final String date = (context.watch<MainDashboardCubit>().dateTimeRange ??
            AppConstants.timeFilter(context).first)
        .key;

    final assetText = appLocalizations
            .home_widget_summaryCard_tooltip_assets_0 +
        (isBlurred
            ? "***"
            : widget.netWorthEntity.assets.newAssetCount.toInt().toString()) +
        appLocalizations.home_widget_summaryCard_tooltip_assets_1 +
        (isBlurred
            ? "***"
            : widget.netWorthEntity.assets.newAssetValue
                .convertMoney()
                .toString());

    final liabilitiesText =
        appLocalizations.home_widget_summaryCard_tooltip_liabilities_0 +
            (isBlurred
                ? "***"
                : widget.netWorthEntity.liabilities.newLiabilityValue
                    .convertMoney()
                    .toString()) +
            appLocalizations.home_widget_summaryCard_tooltip_liabilities_1 +
            (isBlurred
                ? "***"
                : widget.netWorthEntity.liabilities.newLiabilityValue
                    .convertMoney()
                    .toString());

    final List items = [
      [
        appLocalizations.home_label_totalNetWorth,
        widget.netWorthEntity.totalNetWorth.currentValue,
        date,
        widget.netWorthEntity.totalNetWorth.change,
        assetText,
      ],
      [
        appLocalizations.home_label_assets,
        widget.netWorthEntity.assets.currentValue,
        date,
        widget.netWorthEntity.assets.change,
        assetText,
      ],
      if (AppConstants.isRelease2)
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
        SummaryTimeFilter(
          key: const Key('SummaryWidget'),
          bloc: context.read<MainDashboardCubit>(),
          onChange: (value) {
            context
                .read<DashboardAllocationCubit>()
                .getAllocation(dateTime: value);
          },
        ),
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
                      PrivacyBlurWidget(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            (item[1] as double).convertMoney(addDollar: true),
                            style: textTheme.headlineSmall,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Builder(builder: (context) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              BankTooltip(
                                child: Text(
                                  item[2],
                                  style: textTheme.bodySmall!.apply(
                                      color: AppColors.dashBoardGreyTextColor),
                                ),
                                showTooltip: index < 2 && widget.isBankNotEmpty,
                              ),
                              const SizedBox(width: 8),
                              PrivacyBlurWidgetClickable(
                                child: ChangeWidget(
                                  number: item[3],
                                  text: (item[3] as double)
                                      .abs()
                                      .convertMoney(addDollar: true),
                                  isLiabilities: index == 2 ? true : false,
                                ),
                              )
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
