import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';

class PortfolioContributionWidget extends AppStatelessWidget {
  final double portfolioContribution;
  final double holdings;
  final String currencyCode;
  const PortfolioContributionWidget({
    required this.portfolioContribution,
    required this.holdings,
    required this.currencyCode,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Portfolio contribution",
          style: textTheme.bodySmall,
        ),
        Builder(builder: (context) {
          final double portfolioPercentage = portfolioContribution * 100;
          return Text(
            "$portfolioPercentage% of ${holdings.convertMoney(addDollar: true)}",
            style: textTheme.bodyLarge,
          );
        }),
      ],
    );
  }
}