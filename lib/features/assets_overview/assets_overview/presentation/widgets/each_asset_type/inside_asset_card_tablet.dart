import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../assets_overview_inherit.dart';

class InsideAssetCardTablet extends AppStatelessWidget {
  final AssetList asset;
  const InsideAssetCardTablet({Key? key, required this.asset})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final flexList = AssetsOverviewInherit.of(context).flexList;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 20,
        child: Row(
          children: List.generate(flexList.length, (index) {
            return ExpandedIf(
              expanded: flexList[index] != 0,
              flex: flexList[index],
              child: SizedBox(
                width: flexList[index] == 0
                    ? AssetsOverviewInherit.of(context).nonExpandedWidth
                    : null,
                child: Builder(
                  builder: (context) {
                    switch (index) {
                      case 0:
                        return Text(
                          asset.assetName,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        );
                      case 1:
                        return Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(asset.currentValue.convertMoney(
                                addDollar: true, textDollar: true)),
                          ),
                        );
                      case 2:
                        return ChangeWidget(
                            number: asset.yearToDate,
                            text: "${asset.yearToDate}%");
                      case 3:
                        return ChangeWidget(
                            number: asset.inceptionToDate,
                            text: "${asset.inceptionToDate}%");
                      case 4:
                        return Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(asset.geography),
                          ),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
