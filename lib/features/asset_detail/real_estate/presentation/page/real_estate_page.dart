import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/features/asset_detail/real_estate/domain/entity/real_estate_entity.dart';
import '../widgets/summary_widget.dart';

class RealEstateDetailPage extends AppStatelessWidget {
  final RealEstateEntity realEstateEntity;
  const RealEstateDetailPage({
    Key? key,
    required this.realEstateEntity,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(realEstateEntity.name, style: textTheme.headlineSmall),
          const SizedBox(height: 12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(realEstateEntity.realEstateType),
          //     const EditButton(),
          //   ],
          // ),
          // const SizedBox(height: 16),
          RealEstateSummaryWidget(realEstateEntity),
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
