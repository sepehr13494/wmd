import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import '../../data/model/other_asset_more_entity.dart';

class OtherAssetDetailPage extends AppStatelessWidget {
  final OtherAseetMoreEntity entity;
  const OtherAssetDetailPage({super.key, required this.entity});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Container(
      child: Text(entity.toString()),
    );
  }
}
