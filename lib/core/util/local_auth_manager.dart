import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalAuthManager {
  final LocalAuthentication auth;

  LocalAuthManager(this.auth);

  Future<bool> authenticate(BuildContext context) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppLocalizations.of(context)
            .linkAccount_linkAccount_card_manual_title,
        options: const AuthenticationOptions(stickyAuth: true,biometricOnly: true)
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
