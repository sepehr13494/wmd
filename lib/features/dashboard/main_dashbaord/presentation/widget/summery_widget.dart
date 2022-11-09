import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';
import 'package:wmd/core/util/colors.dart';

class SummeryWidget extends AppStatelessWidget {
  const SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final List items = [
      ["Total Net Worth","\$6,406,200","Change in last 7 days","\$30,000 ",true],
      ["Assets","\$8,846,200","Change in last 7 days","\$40,000 ",false],
      ["Liabilities","\$2,438,800","Change in last 7 days","\$10,000 ",true],
    ];
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Column(
      children: [
        Row(
          children: [
            Text("Summery",style: textTheme.titleLarge),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,size: 15,),
                const SizedBox(width: 8),
                Text("last 7 days",style: textTheme.bodyMedium!.toLinkStyle(context)),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,size: 15),
              ],
            )
          ],
        ),
        const SizedBox(height:12),
        RowOrColumn(
          showRow: !isMobile,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final bool isPositive = item[4];
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
                          final color = isPositive ? Colors.green : Colors.red;
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Text(item[2],style: textTheme.bodySmall!.apply(color: AppColors.dashBoardGreyTextColor),),
                                const SizedBox(width: 8),
                                Icon(isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: color,),
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
