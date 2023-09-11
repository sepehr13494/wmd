import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentataion/models/assets_overview_base_widget_model.dart';
import '../assets_overview_inherit.dart';

class AssetTypeTabletTableTitle extends AppStatelessWidget {
  const AssetTypeTabletTableTitle({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final flexList = AssetsOverviewInherit.of(context).flexList;
    final assetOverviewType =
        AssetsOverviewInherit.of(context).assetOverviewBaseType;
    List texts = [
      appLocalizations.assets_table_header_assetName,
      appLocalizations.assets_table_header_currentValue,
      appLocalizations.assets_table_header_itd,
      appLocalizations.assets_table_header_ytd,
    ];
    switch (assetOverviewType) {
      case AssetsOverviewBaseType.assetType:
        texts.add(
          appLocalizations.assets_table_header_geography,
        );
        break;
      case AssetsOverviewBaseType.currency:
      case AssetsOverviewBaseType.geography:
      case AssetsOverviewBaseType.portfolio:
        texts.add(appLocalizations.assets_table_header_assetClass);
        break;
    }
    return Row(
      children: List.generate(texts.length, (index) {
        return ExpandedIf(
          flex: flexList[index],
          expanded: flexList[index] != 0,
          child: SizedBox(
            width: AssetsOverviewInherit.of(context).nonExpandedWidth,
            child: Align(
              // alignment: AlignmentDirectional.centerEnd,
              alignment: _getAlignment(index),
              child: Text(
                texts[index],
                style: textTheme.bodySmall,
              ),
            ),
          ),
        );
      }),
    );
  }

  AlignmentDirectional _getAlignment(int index) {
    switch (index) {
      case 4:
        return AlignmentDirectional.centerEnd;
      case 3:
        return AlignmentDirectional.center;
      case 2:
        return AlignmentDirectional.center;
      default:
        return AlignmentDirectional.centerStart;
    }
  }
}
