import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/global_functions.dart';

class PrivacyToast {
  static showPrivacyModeToast(BuildContext context, bool isBlurred) {
    final appLocalizations = AppLocalizations.of(context);

    if (isBlurred) {
      GlobalFunctions.showSnackTile(
        context,
        color: Colors.green,
        title: Text(appLocalizations
            .profile_tabs_preferences_privacyMode_toast_active_title),
        subtitle: Text(appLocalizations
            .profile_tabs_preferences_privacyMode_toast_active_desc),
      );
    } else {
      GlobalFunctions.showSnackTile(
        context,
        color: Colors.green,
        title: Text(appLocalizations
            .profile_tabs_preferences_privacyMode_toast_disabled_title),
        subtitle: Text(appLocalizations
            .profile_tabs_preferences_privacyMode_toast_disabled_decs),
      );
    }
  }
}
