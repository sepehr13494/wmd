import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/features/asset_detail/private_debt/domain/entity/private_debt_entity.dart';

import '../widgets/summary_widget.dart';

class PrivateDebtDetailPage extends AppStatelessWidget {
  final PrivateDebtEntity privateDebtEntity;
  const PrivateDebtDetailPage({
    Key? key,
    required this.privateDebtEntity,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Stack(
      children: [
        const LeafBackground(
          opacity: 0.1,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(privateDebtEntity.investmentName,
                  style: textTheme.headlineSmall),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(privateDebtEntity.wealthManager),
                  const EditButton(),
                ],
              ),
              const SizedBox(height: 16),
              PrivateDebtSummaryWidget(privateDebtEntity),
            ],
          ),
        ),
      ],
    );
  }
}

class EditButton extends AppStatelessWidget {
  const EditButton({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(2))),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            'Edit details',
            style: textTheme.labelMedium!
                .apply(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
