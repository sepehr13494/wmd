import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

class LocalAuthManager extends Cubit<bool> {
  final LocalAuthentication auth;
  DateTime? lastTime;

  LocalAuthManager(this.auth) : super(sl<LocalStorage>().getLocalAuth());

  Future<bool> authenticate(BuildContext context) async {
    if(AppConstants.developMode){
      return true;
    }else{
      try {
        if (lastTime != null &&
            DateTime.now().difference(lastTime!).inSeconds < 5) {
          return true;
        }
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: AppLocalizations.of(context)
                .linkAccount_linkAccount_card_manual_title,
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: true));
        if (didAuthenticate) {
          lastTime = DateTime.now();
        }
        return didAuthenticate;
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }

  }

  setLocalAuth(val, context) async {
    if (val) {
      sl<LocalStorage>().setLocalAuth(val);
      emit(val);
    } else {
      final didAuth = await authenticate(context);
      if (didAuth) {
        sl<LocalStorage>().setLocalAuth(val);
        emit(val);
      }
    }
  }

  getLocalAuth() {
    emit(sl<LocalStorage>().getLocalAuth());
  }
}
