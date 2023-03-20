import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

class YourHoldingsWidget extends AppStatelessWidget {
  final double holdings;

  const YourHoldingsWidget({
    required this.holdings,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.assets_label_yourHoldings,
          style: textTheme.titleSmall,
        ),
        SizedBox(height: responsiveHelper.biggerGap),
        PrivacyBlurWidget(
          child: Text(
            holdings.convertMoney(addDollar: true),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
