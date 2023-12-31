import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/adb_checker.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/force_update/presentation/manager/force_update_cubit.dart';
import 'package:wmd/features/safe_device/presentation/manager/safe_device_cubit.dart';
import 'package:wmd/global_functions.dart';
import '../manager/splash_cubit.dart';
import '../../../../injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  detectAdb(BuildContext context) async {
    final res = await AdbChecker().adbChecking();
    if (res) {
      // ignore: use_build_context_synchronously
      GlobalFunctions.showSnackBar(
        context,
        // ignore: use_build_context_synchronously
        AppLocalizations.of(context).splash_adb_warning,
        color: Colors.orange[800],
        type: "error",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    detectAdb(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SafeDeviceCubit>()..isSafeDevice(),
        ),
        BlocProvider(
          create: (context) => sl<SplashCubit>()..startTimer(),
        ),
        BlocProvider(
          create: (context) => sl<ForceUpdateCubit>()..getForceUpdate(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<SafeDeviceCubit, SafeDeviceState>(
                listener: (context, state) async {
                  // if (!AppConstants.developMode &&
                  //     state is IsSafeDeviceLoaded) {
                  //   if (!state.isSafeDeviceEntity.isSafe) {
                  //     context.replaceNamed(AppRoutes.unsafe_device);
                  //   }
                  // }
                },
              ),
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
                listener:
                    BlocHelper.defaultBlocListener(listener: (context, state) {
                  // context.read<SplashCubit>().initSplashFromSplash();
                  if (state is GetForceUpdateLoaded) {
                    bool isVersionGreaterThan(
                        String newVersion, String currentVersion) {
                      if (newVersion == currentVersion) {
                        return true;
                      }
                      List<String> currentV = currentVersion.split(".");
                      List<String> newV = newVersion.split(".");
                      bool a = false;
                      for (var i = 0; i <= 2; i++) {
                        a = int.parse(newV[i]) > int.parse(currentV[i]);
                        if (int.parse(newV[i]) != int.parse(currentV[i])) break;
                      }
                      return a;
                    }

                    final appVersion = sl<PackageInfo>().version;
                    final versionFromServer =
                        state.getForceUpdateEntity.appVersion;
                    if (!isVersionGreaterThan(appVersion, versionFromServer) &&
                        state.getForceUpdateEntity.isForceUpdate) {
                      //show force update page
                      context.replaceNamed(AppRoutes.forceUpdate);
                    } else {
                      //move on with app
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
