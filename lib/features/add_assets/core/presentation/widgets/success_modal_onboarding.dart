import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessModalOnboardingWidget extends ModalWidget {
  final String startingBalance, currencyCode, netWorth, netWorthChange;
  final double currencyRate;

  const SuccessModalOnboardingWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.startingBalance,
    required this.currencyCode,
    required this.currencyRate,
    required this.netWorth,
    required this.netWorthChange,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          buildModalHeader(context,
              onClose: () => context.goNamed(AppRoutes.addAssetsView)),
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/success.svg",
                      height: 70,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations
                                .common_formSuccessModal_newUser_title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: responsiveHelper.xxLargeFontSize),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            appLocalizations
                                .common_formSuccessModal_newUser_description,
                            textAlign: TextAlign.center,
                            style: appTextTheme.bodyMedium,
                          ),
                          SizedBox(height: responsiveHelper.biggerGap),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          appLocalizations
                              .common_formSuccessModal_newUser_netWorth,
                          textAlign: TextAlign.center,
                          style: appTextTheme.bodySmall,
                        ),
                        SizedBox(height: responsiveHelper.defaultSmallGap),
                        Text(
                          '\$$netWorth',
                          textAlign: TextAlign.center,
                          style: appTextTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    buildActionContainer(context),
                    SizedBox(
                      height: responsiveHelper.bigger16Gap,
                    )
                  ]))
        ],
      ),
    );
  }

  ///  Action Buttons Container of Modal
  @override
  Widget buildActionContainer(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap * 5),
        child: RowOrColumn(
          showRow: !isMobile,
          children: [
            OutlinedButton(
              onPressed: () {
                // View Asset detail button
                context.goNamed(AppRoutes.addAssetsView);
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(appLocalizations.common_button_continue),
            ),
          ],
        ));
  }
}
