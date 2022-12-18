import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class NetChangeWidget extends AppStatelessWidget {
  final double current;
  final double old;
  const NetChangeWidget({
    required this.current,
    required this.old,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);
    final diff = (current - old);
    final value = diff.convertMoney(addDollar: true);
    final percent = diff / old * 100;
    return Column(
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
            // ),
          ],
        ),
        SizedBox(height: responsiveHelper.defaultGap),
        Text(
          "Last 30 days",
          style: textTheme.bodySmall,
        ),
        Row(
          children: [
            Text(
              value,
              style: textTheme.bodyLarge,
            ),
            ChangeWidget(number: percent, text: "$percent%"),
          ],
        ),
      ],
    );
  }
}
