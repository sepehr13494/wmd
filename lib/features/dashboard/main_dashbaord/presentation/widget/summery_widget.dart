import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  String date = "All times";

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final List items = [
      ["Total Net Worth",widget.netWorthEntity.totalNetWorth.currentValue,"Change $date",widget.netWorthEntity.totalNetWorth.change],
      ["Assets",widget.netWorthEntity.assets.currentValue,"Change $date",widget.netWorthEntity.assets.change],
      ["Liabilities",widget.netWorthEntity.liabilities.currentValue,"Change $date",widget.netWorthEntity.liabilities.change],
    ];
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Column(
      children: [
        Row(
          children: [
            Text("Summery",style: textTheme.titleLarge),
            const Spacer(),
            InkWell(
              onTap: (){
                showDateRangePicker(context: context, firstDate: DateTime.now().subtract(const Duration(days: 360)), lastDate: DateTime.now()).then((value) {
                  if(value != null){
                    date = value.toString();
                    context.read<MainDashboardCubit>().getNetWorth(dateTimeRange: value);
                  }
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,size: 15,),
                  const SizedBox(width: 8),
                  Text(date,style: textTheme.bodyMedium!.toLinkStyle(context)),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down,size: 15),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height:12),
        RowOrColumn(
          showRow: !isMobile,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final bool isPositive = item[3] > 0;
            final bool isZero = item[3] == 0;
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
                      Text(item[1],style: textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final color = isZero ? null : (isPositive ? Colors.green : Colors.red);
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Text(item[2],style: textTheme.bodySmall!.apply(color: AppColors.dashBoardGreyTextColor),),
                                const SizedBox(width: 8),
                                isZero ? const SizedBox() : Icon(isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: color,),
                                Text(item[3],style: TextStyle(color: color),),
                              ],
                            ),
                          );
                        }
                      )
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
