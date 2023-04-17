import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/firebase_analytics.dart';

class FailedOtpAuthBottomSheet extends AppStatelessWidget {
  final VoidCallback callback;
  const FailedOtpAuthBottomSheet({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SizedBox(
      height: isMobile
          ? responsiveHelper.optimalDeviceHeight * 0.5
          : responsiveHelper.optimalDeviceHeight * 0.3,
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
                onTap: () {
                  callback();
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    appLocalizations.common_errors_otpFailedHeading,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    appLocalizations.common_errors_otpFaildDescription,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: responsiveHelper.bigger24Gap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // context.goNamed(AppRoutes.assetDetailPage,
                        //     queryParams: {'assetId': assetId, 'type': assetType});
                        callback();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      child: Text("Okay"),
                    ),
                  ],
                )
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
