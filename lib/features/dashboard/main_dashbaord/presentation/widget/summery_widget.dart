import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/entities/net_worth_entity.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class SummeryWidget extends StatefulWidget {
  final NetWorthEntity netWorthEntity;
  const SummeryWidget({Key? key,required this.netWorthEntity}) : super(key: key);

  @override
  AppState<SummeryWidget> createState() => _SummeryWidgetState();
}

class _SummeryWidgetState extends AppState<SummeryWidget> {

  static const _timeFilter = [
    MapEntry<String, int>("7 days", 7),
    MapEntry<String, int>("30 days", 30),
  ];


  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final String date = (context.watch<MainDashboardCubit>().dateTimeRange??_timeFilter[0]).key;
    final List items = [
      ["Total Net Worth",widget.netWorthEntity.totalNetWorth.currentValue,"Change in last $date",widget.netWorthEntity.totalNetWorth.change,"tooltip info"],
      ["Assets",widget.netWorthEntity.assets.currentValue,"Change in last $date",widget.netWorthEntity.assets.change,"tooltip info"],
      ["Liabilities",widget.netWorthEntity.liabilities.currentValue,"Change in last $date",widget.netWorthEntity.liabilities.change,"tooltip info"],
    ];
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Column(
      children: [
        Row(
          children: [
            Text(appLocalizations.home_subheading, style: textTheme.titleLarge),
            const Spacer(),
            Icon(
              Icons.calendar_month,
              size: 15,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            DropdownButton<MapEntry<String, int>>(
              items: _timeFilter
                  .map((e) => DropdownMenuItem<MapEntry<String, int>>(
                  value: e,
                  child: Text(
                    e.key,
                    style: textTheme.bodyMedium!.apply(color: Theme.of(context).primaryColor),
                    // textTheme.bodyMedium!.toLinkStyle(context),
                  )))
                  .toList(),
              onChanged: ((value) {
                if (value != null) {
                  context.read<MainDashboardCubit>().getNetWorth(dateTimeRange: value);
                }
              }),
              value: context.read<MainDashboardCubit>().dateTimeRange??_timeFilter[0],
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              // style: textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height:12),
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
                      TextWithInfo(title: item[0], hasInfo: true),
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
