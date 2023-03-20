import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/assets_overview_inherit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/assets_overview/core/presentataion/models/assets_overview_base_widget_model.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

import '../../../../core/domain/entities/assets_list_entity.dart';
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
                          PrivacyBlurWidget(
                            child: Text(
                              asset.assetName.length > 15
                                  ? '${asset.assetName.substring(0, 15)}..'
                                  : asset.assetName,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            AssetsOverviewInherit.of(context)
                                        .assetOverviewBaseType ==
                                    AssetsOverviewBaseType.assetType
                                ? asset.geography
                                : AssetsOverviewChartsColors.getAssetType(
                                    appLocalizations, asset.type),
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
              PrivacyBlurWidget(
                child: Text(
                  asset.currentValue.convertMoney(addDollar: true),
                  style: textTheme.bodyMedium!.apply(
                      color: asset.currentValue.isNegative
                          ? AppColors.errorColor
                          : null),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  ChangeWidget(
                    number: asset.inceptionToDate,
                    text: "${asset.inceptionToDate.toStringAsFixed(1)}%",
                    tooltipMessage: (asset.inceptionToDate >= 99900 ||
                            asset.inceptionToDate <= -100)
                        ? appLocalizations.assets_tooltips_percentageAbsurd
                        : null,
                  ),
                  const SizedBox(width: 8),
                  ChangeWidget(
                    number: asset.yearToDate,
                    text: "${asset.yearToDate.toStringAsFixed(1)} %",
                    tooltipMessage:
                        (asset.yearToDate >= 99900 || asset.yearToDate <= -100)
                            ? appLocalizations.assets_tooltips_percentageAbsurd
                            : null,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
