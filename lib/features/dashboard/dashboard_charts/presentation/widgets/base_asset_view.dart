import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';

import '../models/each_asset_model.dart';

class BaseAssetView extends AppStatelessWidget {
  final String title;
  final String secondTitle;
  final Widget child;
  final Widget emptyChild;
  final Function onMoreTap;
  final List<EachAssetViewModel> assets;

  const BaseAssetView(
      {Key? key,
      required this.title,
      required this.secondTitle,
      required this.child,
      required this.emptyChild,
      required this.onMoreTap,
      required this.assets})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
            thickness: 0.7, color: AppColors.dashBoardGreyTextColor),
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
                  if (assets.isEmpty == false)
                    InkWell(
                      onTap: assets.isEmpty
                          ? null
                          : () {
                              if (title ==
                                  appLocalizations
                                      .home_widget_assetClassAllocation_title) {
                                AnalyticsUtils.triggerEvent(
                                    action: AnalyticsUtils
                                        .geographyWidgetMoreAction,
                                    params: AnalyticsUtils
                                        .assetClassMoreRedirectionEvent);
                              } else {
                                AnalyticsUtils.triggerEvent(
                                    action: AnalyticsUtils
                                        .geographyWidgetMoreAction,
                                    params: AnalyticsUtils
                                        .geographyMoreRedirectionEvent);
                              }
                              context.read<MainPageCubit>().onItemTapped(1);
                              onMoreTap();
                            },
                      child: Row(
                        children: [
                          Text(
                              appLocalizations
                                  .home_widget_geography_button_more,
                              style: textTheme.bodySmall!.toLinkStyle(context)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                        ],
                      ),
                    )
                ],
              ),
              child,
              Builder(builder: (context) {
                if (assets.isEmpty) {
                  return emptyChild;
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          secondTitle,
                          style: textTheme.bodySmall!
                              .apply(color: AppColors.dashBoardGreyTextColor),
                        ),
                        const Spacer(),
                        Text(
                          appLocalizations
                              .home_widget_geography_label_allocation,
                          style: textTheme.bodySmall!
                              .apply(color: AppColors.dashBoardGreyTextColor),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              }),
              Builder(builder: (context) {
                final List<EachAssetViewModel> nonZeroList =
                    assets.where((element) => element.value != 0).toList();
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      EachAssetViewModel asset = nonZeroList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            asset.color == null
                                ? const SizedBox()
                                : Container(
                                    width: 6, height: 6, color: asset.color),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: PrivacyBlurWidget(
                                  child: Text(asset.name,
                                      style: textTheme.bodySmall),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            PrivacyBlurWidget(
                                child: Text(asset.price,
                                    style: textTheme.bodySmall)),
                            Container(
                              width: 0.5,
                              height: 10,
                              color: textTheme.bodySmall!.color!,
                            ),
                            Text(asset.percentage, style: textTheme.bodySmall),
                            InkWell(
                              onTap: () {
                                if (title ==
                                    appLocalizations
                                        .home_widget_assetClassAllocation_title) {
                                  AnalyticsUtils.triggerEvent(
                                      action: AnalyticsUtils
                                          .assetExposureArrowAction,
                                      params: AnalyticsUtils
                                          .assetOverviewInsideMoreEvent);
                                } else {
                                  AnalyticsUtils.triggerEvent(
                                      action: AnalyticsUtils
                                          .assetExposureArrowAction,
                                      params: AnalyticsUtils
                                          .geographyOverviewInsideMoreEvent);
                                }
                                context.read<MainPageCubit>().onItemTapped(1);
                                onMoreTap();
                              },
                              child: const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 15),
                            )
                          ]
                              .map((e) => e is Expanded
                                  ? e
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: e,
                                    ))
                              .toList(),
                        ),
                      );
                    },
                    separatorBuilder: (context, _) => const Divider(),
                    itemCount: nonZeroList.length);
              })
            ],
          ),
        ),
      ),
    );
  }
}
