import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/custom_icons.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/profile/preference/presentation/manager/preference_cubit.dart';
import 'package:wmd/injection_container.dart';

class TwoFactorRecommendationWidget extends AppStatelessWidget {
  final Function onClose;
  const TwoFactorRecommendationWidget({super.key, required this.onClose});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return BlocProvider(
        create: (context) => sl<PreferenceCubit>()..getPreference(),
        child: BlocConsumer<PreferenceCubit, PreferenceState>(
            listener:
                BlocHelper.defaultBlocListener(listener: (context, state) {}),
            builder: (context, state) {
              if (state is GetPreferenceLoaded &&
                  state.entity.showMobileBanner == true) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 6 : 4.0,
                      horizontal: isMobile ? 8 : 0),
                  child: Card(
                    color: AppColors.blueCardColor,
                    child: Padding(
                        padding: EdgeInsets.all(responsiveHelper.biggerGap),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<PreferenceCubit>()
                                        .patchPreferenceMobileBanner(
                                            map: {"showMobileBanner": false});
                                    onClose();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            RowOrColumn(
                              showRow: !isMobile,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ExpandedIf(
                                  expanded: false,
                                  child: Row(
                                    children: [
                                      if (isMobile) const SizedBox(width: 20),
                                      SvgPicture.asset(
                                        "assets/images/shield_lock.svg",
                                        height: 35,
                                      ),
                                      SizedBox(width: isMobile ? 32 : 20),
                                      Column(
                                        crossAxisAlignment: isMobile
                                            ? CrossAxisAlignment.center
                                            : CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: isMobile
                                                  ? responsiveHelper
                                                          .optimalDeviceWidth *
                                                      0.5
                                                  : min(
                                                      responsiveHelper
                                                              .optimalDeviceWidth *
                                                          0.35,
                                                      300),
                                              child: Text(
                                                appLocalizations
                                                    .home_twoFactorRecommendation_title,
                                                style: textTheme.titleMedium,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          const SizedBox(height: 12),
                                          SizedBox(
                                            width: isMobile
                                                ? responsiveHelper
                                                        .optimalDeviceWidth *
                                                    0.5
                                                : min(
                                                    responsiveHelper
                                                            .optimalDeviceWidth *
                                                        0.3,
                                                    300),
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
                                    ? SizedBox(
                                        width: responsiveHelper.defaultSmallGap)
                                    : SizedBox(
                                        height: responsiveHelper.bigger16Gap),
                                ExpandedIf(
                                    expanded: false,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<PreferenceCubit>()
                                              .patchPreferenceMobileBanner(
                                                  map: {
                                                "showMobileBanner": false
                                              });
                                          context.pushNamed(
                                              AppRoutes.twoFactorAuth);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(appLocalizations
                                                .home_twoFactorRecommendation_btn),
                                            const SizedBox(width: 8),
                                            const Icon(Icons.arrow_right),
                                          ],
                                        ))),
                                if (isMobile)
                                  SizedBox(height: responsiveHelper.bigger16Gap)
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
