import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.assets_label_portfolioContribution,
          style: textTheme.bodySmall,
        ),
        Builder(builder: (context) {
          // final double portfolioPercentage = portfolioContribution * 100;
          return Text(
            "${portfolioContribution.toStringAsFixed(1)}% of ${netWorth.convertMoney(addDollar: true)}",
            style: textTheme.bodyLarge,
          );
        }),
      ],
    );
  }
}
