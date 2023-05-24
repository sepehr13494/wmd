import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/firebase_analytics.dart';

class DisableTwoFactorBottomSheet extends AppStatelessWidget {
  final VoidCallback callback;
  const DisableTwoFactorBottomSheet({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SizedBox(
      height: isMobile
          ? responsiveHelper.optimalDeviceHeight * 0.5
          : responsiveHelper.optimalDeviceHeight * 0.4,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: textTheme.titleMedium!.color!.withOpacity(0.3)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                splashColor: Theme.of(context).primaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    !isMobile ? responsiveHelper.optimalDeviceWidth * 0.25 : 0),
            child: Column(
              children: [
                Text(
                  appLocalizations.profile_twofactorauthentication_modal_title,
                  textAlign: TextAlign.left,
                  style: textTheme.headlineSmall,
                ),
                Text(
                  appLocalizations
                      .profile_twofactorauthentication_modal_description,
                  textAlign: TextAlign.left,
                  style: textTheme.bodyMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    // context.goNamed(AppRoutes.assetDetailPage,
                    //     queryParams: {'assetId': assetId, 'type': assetType});
                    callback();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize:
                          Size(responsiveHelper.optimalDeviceWidth * 0.85, 50)),
                  child: Text(
                    appLocalizations.common_button_yesTurnOff2FA,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize:
                          Size(responsiveHelper.optimalDeviceWidth * 0.85, 50)),
                  child: Text(
                    appLocalizations.common_button_cancel,
                  ),
                )
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: e,
                      ))
                  .toList(),
            ),
          )
        ]
            .map((e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
