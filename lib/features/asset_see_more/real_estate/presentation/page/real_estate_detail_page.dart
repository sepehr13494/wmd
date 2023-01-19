import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import 'data/model/real_estate_more_entity.dart';

class RealEstateDetailPage extends AppStatelessWidget {
  final RealEstateMoreEntity entity;
  const RealEstateDetailPage({super.key, required this.entity});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      children: [
        Text(entity.name),
        Text(entity.realEstateType),
        Text(entity.asOfDate.toString()),
        Text(entity.yearToDate.toString()),
        Text(entity.holdings.toString()),
      ],
    );
  }
}
