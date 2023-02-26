import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import '../manager/splash_cubit.dart';
import '../../../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..initSplash(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) async {
              if (state is SplashLoaded) {
                if (state.isLogin) {
                  if (sl<LocalStorage>().getLocalAuth()) {
                    final bool didAuth = await context
                        .read<LocalAuthManager>()
                        .authenticate(context);
                    if (didAuth) {
                      // ignore: use_build_context_synchronously
                      context.goNamed(AppRoutes.main);
                    } else {
                      // ignore: use_build_context_synchronously
                      context.goNamed(AppRoutes.login);
                    }
                  } else {
                    context.goNamed(AppRoutes.login);
                  }
                } else {
                  context.goNamed(AppRoutes.welcome);
                }
              }
            },
            child: LayoutBuilder(builder: (context, snapShot) {
              return Center(
                child: SvgPicture.asset(
                  "assets/images/logo_splash.svg",
                  width: snapShot.maxWidth * 0.7,
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
