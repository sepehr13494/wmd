import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';

class BankAccountDetailPage extends AppStatelessWidget {
  final BankAccountEntity bankEntity;
  const BankAccountDetailPage({
    Key? key,
    required this.bankEntity,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final lineColor = Theme.of(context).scaffoldBackgroundColor;
    return Stack(
      children: [
        const LeafBackground(
          opacity: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bankEntity.bankName ?? 'Bank account',
                  style: textTheme.headlineSmall),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bankEntity.description ?? ''),
                  const EditButton(),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(color: lineColor),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(),
              ),
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
