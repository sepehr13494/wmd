import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';

class AppRestart {
  static restart(BuildContext context) {
    context.goNamed(AppRoutes.login);
  }
}
