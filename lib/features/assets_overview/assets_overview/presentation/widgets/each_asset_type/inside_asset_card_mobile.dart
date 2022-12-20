import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/assets_overview_entity.dart';

class InsideAssetCardMobile extends AppStatelessWidget {
  final AssetList asset;
  const InsideAssetCardMobile({Key? key,required this.asset}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.link,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              asset.assetName,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Text(asset.geography),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(asset.currentValue.convertMoney(addDollar: true)),
              Row(
                children: [
                  ChangeWidget(number: asset.yearToDate, text: "${asset.yearToDate}%"),
                  const SizedBox(width: 8),
                  ChangeWidget(number: asset.inceptionToDate, text: "${asset.inceptionToDate}%"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}