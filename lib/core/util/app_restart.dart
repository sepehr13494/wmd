import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

class AppRestart {
  static restart(BuildContext context) async {
    await sl<LocalStorage>().logout();
    // ignore: use_build_context_synchronously
    context.goNamed(AppRoutes.login);
  }
}
