import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/features/asset_detail/private_equity/domain/entity/private_equity_entity.dart';

import '../widgets/summary_widget.dart';

class PrivateEquityDetailPage extends AppStatelessWidget {
  final PrivateEquityEntity privateEquityEntity;
  const PrivateEquityDetailPage({
    Key? key,
    required this.privateEquityEntity,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(privateEquityEntity.investmentName,
              style: textTheme.headlineSmall),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(privateEquityEntity.wealthManager),
              // const EditButton(),
            ],
          ),
          const SizedBox(height: 16),
          PrivateEquitySummaryWidget(privateEquityEntity),
        ],
      ),
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
