import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import '../../../domain/entities/assets_overview_entity.dart';

class InsideAssetCardMobile extends AppStatelessWidget {
  final AssetList asset;

  const InsideAssetCardMobile({Key? key, required this.asset})
      : super(key: key);

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
                    // if(asset.isLinked)
                    //   const Icon(
                    //     Icons.link,
                    //     color: Colors.grey,
                    //   ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            asset.assetName.length > 15
                                ? '${asset.assetName.substring(0, 15)}..'
                                : asset.assetName,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            asset.geography,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                asset.currentValue.convertMoney(addDollar: true),
                style: textTheme.bodyMedium!.apply(
                    color: asset.currentValue.isNegative
                        ? AppColors.errorColor
                        : null),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  ChangeWidget(
                      number: asset.inceptionToDate,
                      text: "${asset.inceptionToDate.toStringAsFixed(1)}%"),
                  const SizedBox(width: 8),
                  ChangeWidget(
                      number: asset.yearToDate, text: "${asset.yearToDate.toStringAsFixed(1)} %"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
