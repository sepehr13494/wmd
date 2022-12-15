import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class NetChangeWidget extends AppStatelessWidget {
  const NetChangeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);
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
              "\$1,326,320",
              style: textTheme.bodyLarge,
            ),
            const ChangeWidget(number: 8.03, text: "8.03%"),
          ],
        ),
      ],
    );
  }
}
