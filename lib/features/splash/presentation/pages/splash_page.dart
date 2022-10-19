import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import '../../../../core/presentation/bloc/bloc_helpers.dart';
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
      child: BlocListener<SplashCubit, SplashState>(
        listener: BlocHelper.defaultBlocListener(
          listener: (context, state) {
            if (state is SplashLoaded) {
              context.goNamed(AppRoutes.addAssetsView);
            }
          },
        ),
        child: Scaffold(
          body: LayoutBuilder(builder: (context, snapShot) {
            return Center(
              child: SvgPicture.asset(
                  "assets/images/logo.svg",
                width: snapShot.maxWidth * 0.7,
              ),
            );
          }),
        ),
      ),
    );
  }
}
