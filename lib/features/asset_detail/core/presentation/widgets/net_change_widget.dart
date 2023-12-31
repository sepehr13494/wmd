import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

class NetChangeWidget extends AppStatelessWidget {
  // final double current;
  final double change;
  final int days;
  const NetChangeWidget({
    // required this.current,
    required this.change,
    required this.days,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       appLocalizations.assets_label_netChange,
        //       style: textTheme.titleSmall,
        //     ),
        //     TextButton(
        //       onPressed: () {
        //         showSeeMoreModal(context: context);
        //       },
        //       child: Text(
        //         '${appLocalizations.common_button_seeMore} >',
        //         style: textTheme.labelSmall!.apply(
        //             color: Theme.of(context).primaryColor,
        //             decoration: TextDecoration.underline),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: responsiveHelper.defaultGap),
        Text(
          appLocalizations.assets_label_lastDurationDays
              .replaceFirstMapped('{{duration}}', (match) => days.toString()),
          style: textTheme.bodySmall,
        ),
        PrivacyBlurWidget(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(builder: (context) {
              late final String symbol;
              if (change == 0) {
                symbol = '+';
              } else if (change < 0) {
                symbol = '';
              } else {
                symbol = '+';
              }
              return Text(
                '$symbol ${change.convertMoney(addDollar: true)}',
                style: textTheme.bodyLarge,
              );
            }),
          ),
        ),
        // Row(
        //   children: [
        //     Text(
        //       change.convertMoney(addDollar: true),
        //       style: textTheme.bodyLarge,
        //     ),
        //     // const SizedBox(width: 4),
        //     // ChangeWidget(number: percent, text: "$percent%"),
        //   ],
        // ),
      ],
    );
  }
}
