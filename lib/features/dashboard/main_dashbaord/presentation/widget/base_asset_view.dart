import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

import '../models/each_asset_model.dart';

class BaseAssetView extends AppStatelessWidget {
  final String title;
  final Widget child;
  final Function onMoreTap;
  final List<EachAssetViewModel> assets;

  const BaseAssetView(
      {Key? key,
      required this.title,
      required this.child,
      required this.onMoreTap,
      required this.assets})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(thickness: 0.7, color: AppColors.dashBoardGreyTextColor),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text("More",
                          style: textTheme.bodySmall!.toLinkStyle(context)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                    ],
                  )
                ],
              ),
              child,
              Row(
                children: [
                  Text(
                    "Asset Class",
                    style: textTheme.bodySmall!
                        .apply(color: AppColors.dashBoardGreyTextColor),
                  ),
                  const Spacer(),
                  Text(
                    "Allocation",
                    style: textTheme.bodySmall!
                        .apply(color: AppColors.dashBoardGreyTextColor),
                  ),
                ],
              ),
              const Divider(),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    EachAssetViewModel asset = assets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          asset.color == null
                              ? const SizedBox()
                              : Container(
                                  width: 6, height: 6, color: asset.color),
                          Text(asset.name,style: textTheme.bodySmall),
                          const Spacer(),
                          Text(asset.price,style: textTheme.bodySmall),
                          Container(
                            width: 0.5,
                            height: 10,
                            color: textTheme.bodySmall!.color!,
                          ),
                          Text(asset.percentage,style: textTheme.bodySmall),
                          const Icon(Icons.arrow_forward_ios_rounded,size: 15)
                        ]
                            .map((e) => e is Spacer
                                ? e
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 3),
                                    child: e,
                                  ))
                            .toList(),
                      ),
                    );
                  },
                  separatorBuilder: (context, _) => const Divider(),
                  itemCount: assets.length)
            ],
          ),
        ),
      ),
    );
  }
}
