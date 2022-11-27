import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../assets_overview_inherit.dart';

class AssetTypeTabletTableTitle extends AppStatelessWidget {

  const AssetTypeTabletTableTitle({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final flexList = AssetsOverviewInherit.of(context).flexList;
    List texts = [
      "Asset name",
      "Current value",
      "ITD",
      "YTD",
      "Geography",
    ];
    return Row(
      children: List.generate(texts.length, (index) {
        return ExpandedIf(
          flex: flexList[index],
          expanded: flexList[index] != 0,
          child: SizedBox(
            width: AssetsOverviewInherit.of(context).nonExpandedWidth,
            child: Align(
              alignment: index == texts.length-1 ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
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
}