import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';

class YourHoldingsWidget extends AppStatelessWidget {
  final double holdings;
  final String currencyCode;
  const YourHoldingsWidget({
    required this.holdings,
    required this.currencyCode,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final String currencySymbol =
        AppConstants.getCurrencySymbolByCode(currencyCode);
    final responsiveHelper = ResponsiveHelper(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your holdings',
          style: textTheme.titleSmall,
        ),
        SizedBox(height: responsiveHelper.biggerGap),
        Text(
          currencySymbol + holdings.toInt().toString(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
