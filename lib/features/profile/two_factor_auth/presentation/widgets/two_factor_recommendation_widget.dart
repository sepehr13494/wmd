import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/custom_icons.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

class TwoFactorRecommendationWidget extends AppStatelessWidget {
  const TwoFactorRecommendationWidget({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: AppColors.blueCardColor,
        child: Padding(
          padding: EdgeInsets.all(responsiveHelper.biggerGap),
          child: RowOrColumn(
            showRow: !isMobile,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExpandedIf(
                expanded: !isMobile,
                child: Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: responsiveHelper.optimalDeviceWidth * 0.7,
                            child: Text(
                              appLocalizations
                                  .home_twoFactorRecommendation_title,
                              style: textTheme.titleMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: responsiveHelper.optimalDeviceWidth * 0.7,
                          child: Text(
                            appLocalizations
                                .home_twoFactorRecommendation_description,
                            style: textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              !isMobile
                  ? SizedBox(width: responsiveHelper.bigger16Gap)
                  : SizedBox(height: responsiveHelper.bigger16Gap),
              ExpandedIf(
                  expanded: !isMobile,
                  child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.settings);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(appLocalizations
                              .home_twoFactorRecommendation_btn),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_right),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
