import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/force_update/presentation/manager/force_update_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          sl<SplashCubit>()..startTimer(),
        ),
        BlocProvider(
          create: (context) =>
          sl<ForceUpdateCubit>()
            ..getForceUpdate(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<SplashCubit, SplashState>(
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
              ),
              BlocListener<ForceUpdateCubit, ForceUpdateState>(
                listener: BlocHelper.defaultBlocListener(listener: (context, state) {
                  if(state is GetForceUpdateLoaded){
                    if(state.getForceUpdateEntity.isForceUpdate){
                      context.replaceNamed(AppRoutes.forceUpdate);
                    }else{
                      context.read<SplashCubit>().initSplashFromSplash();
                    }
                  }
                }),
              ),
            ],
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
