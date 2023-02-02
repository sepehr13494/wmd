import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

import '../../util/app_restart.dart';
import '../routes/app_routes.dart';

class LocalAuthWrapper extends StatefulWidget {
  final Widget child;
  const LocalAuthWrapper({Key? key, required this.child}) : super(key: key);

  @override
  AppState<LocalAuthWrapper> createState() => _LocalAuthWrapperState();
}

class _LocalAuthWrapperState extends AppState<LocalAuthWrapper>
    with WidgetsBindingObserver {
  bool showContent = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        LocalAuthManager localAuthManager = context.read<LocalAuthManager>();
        if (state == AppLifecycleState.resumed) {
          if (localAuthManager.state) {
            setState(() {
              showContent = false;
            });
            _checkAuth();
          }
        }
      }
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    if (showContent) {
      return widget.child;
    }
    return Scaffold(
      body: LayoutBuilder(builder: (context, snapShot) {
        return Center(
          child: SvgPicture.asset(
            "assets/images/logo.svg",
            width: snapShot.maxWidth * 0.7,
          ),
        );
      }),
    );
  }

  Future<void> _checkAuth() async {
    final LocalAuthManager localAuthManager = context.read<LocalAuthManager>();
    if (localAuthManager.state) {
      final didAuth = await localAuthManager.authenticate(context);
      if (didAuth) {
        // ignore: use_build_context_synchronously
        log('MErt:  pop');
        showContent = true;
      } else {
        // ignore: use_build_context_synchronously
        log('MErt:  goLogin');
        // sl<LocalStorage>().logout();
        // AppRestart.restart(context);
        // ignore: use_build_context_synchronously
        context.goNamed(AppRoutes.login);
      }
    } else {
      log('MErt:  elsee');
      showContent = true;
    }
    setState(() {});
  }
}
