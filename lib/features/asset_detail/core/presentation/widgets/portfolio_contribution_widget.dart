import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

class PortfolioContributionWidget extends AppStatelessWidget {
  final double portfolioContribution;
  final double netWorth;

  const PortfolioContributionWidget({
    required this.portfolioContribution,
    required this.netWorth,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final value = portfolioContribution == 0
        ? '0'
        : portfolioContribution.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.assets_label_portfolioContribution,
          style: textTheme.bodySmall,
        ),
        PrivacyBlurWidget(
          child: Text(
            "$value% of ${netWorth.convertMoney(addDollar: true)}",
            style: textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
