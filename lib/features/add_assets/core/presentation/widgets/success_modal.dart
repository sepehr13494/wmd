import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';

class SuccessModalWidget extends ModalWidget {
  final String startingBalance,
      currencyCode,
      netWorth,
      netWorthChange,
      assetId,
      assetType;
  final double currencyRate;

  const SuccessModalWidget({
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
    required this.assetId,
    required this.assetType,
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
          ? MediaQuery.of(context).size.height * 0.8
          : max(MediaQuery.of(context).size.height * 0.5,
              min(615, MediaQuery.of(context).size.width)),
      child: Column(
        children: [
          buildModalHeader(context,
              onClose: () => context.goNamed(AppRoutes.main)),
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[300]),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: responsiveHelper.xxLargeFontSize),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            appLocalizations
                                .common_formSuccessModal_description,
                            textAlign: TextAlign.center,
                            style: appTextTheme.bodyMedium,
                          ),
                          SizedBox(height: responsiveHelper.biggerGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appLocalizations
                                        .common_formSuccessModal_startingBalance,
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  if (AppConstants.isRelease1)
                                    Text(
                                      "USD $startingBalance",
                                      textAlign: TextAlign.center,
                                      style: appTextTheme.bodyLarge,
                                    ),
                                  if (!AppConstants.isRelease1) ...[
                                    Text(
                                      "$currencyCode  \$$startingBalance",
                                      textAlign: TextAlign.center,
                                      style: appTextTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                        height:
                                            responsiveHelper.defaultSmallGap),
                                    Text(
                                      '${currencyRate.toInt()} $currencyCode = 1 USD',
                                      textAlign: TextAlign.center,
                                      style: appTextTheme.bodySmall,
                                    ),
                                  ]
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Net Worth',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Text(
                                    '\$$netWorth',
                                    textAlign: TextAlign.center,
                                    style: appTextTheme.bodyLarge,
                                  ),
                                  SizedBox(
                                      height: responsiveHelper.defaultSmallGap),
                                  Row(
                                    children: [
                                      if (assetType != "LoanLiability")
                                        Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.green[400],
                                        ),
                                      if (assetType == "LoanLiability")
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.red[800],
                                        ),
                                      Text(
                                        '\$$netWorthChange',
                                        textAlign: TextAlign.center,
                                        style: appTextTheme.bodySmall
                                            ?.merge(TextStyle(
                                          color: assetType == "LoanLiability"
                                              ? Colors.red[800]
                                              : Colors.green[400],
                                        )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    buildActionContainer(context),
                    SizedBox(height: responsiveHelper.bigger16Gap * 3),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(height: 1.3),
                            children: [
                          TextSpan(
                              text:
                                  "${appLocalizations.common_help_needSupport} ",
                              style: appTextTheme.titleMedium),
                          TextSpan(
                            text: "Get in touch",
                            style: appTextTheme.titleMedium!
                                .toLinkStyleSecondary(context),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.goNamed(AppRoutes.support);
                              },
                          ),
                        ])),
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
            ExpandedIf(
              expanded: !isMobile,
              child: OutlinedButton(
                onPressed: () {
                  // View Asset detail button
                  context.goNamed(AppRoutes.addAssetsView);
                },
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
                child: Text(
                  cancelBtn,
                ),
              ),
            ),
            !isMobile
                ? SizedBox(width: responsiveHelper.bigger16Gap)
                : SizedBox(height: responsiveHelper.bigger16Gap),
            ExpandedIf(
                expanded: !isMobile,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(AppRoutes.assetDetailPage,
                        queryParams: {'assetId': assetId, 'type': assetType});
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(assetType == "LoanLiability"
                      ? appLocalizations
                          .common_formSuccessModal_buttons_viewLiability
                      : confirmBtn),
                ))
          ],
        ));
  }
}
