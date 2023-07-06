import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_url_launcher.dart';

class ForceUpdatePage extends AppStatelessWidget {
  const ForceUpdatePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/app_logo.svg",
              height: 60,
              width: 120,
            ),
            Text(
              "Stay Connected - Update Required",
              style: textTheme.titleMedium,
            ),
            Text(
              "to continue using the app, please update\nto the latest version",
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(),
            SizedBox(
                width: 120,
                child: ElevatedButton(
                    onPressed: () {
                      if (!kIsWeb) {
                        if (Platform.isAndroid) {
                          AppUrlLauncher.appLaunchUrl(
                              "https://play.google.com/store/apps/details?id=com.aiop.aio");
                        } else if (Platform.isIOS) {
                          AppUrlLauncher.appLaunchUrl(
                              "https://apps.apple.com/us/app/all-in-one/id6450203481");
                        }
                      }
                    },
                    child: const Text("Update"))),
          ]
              .map((e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
