import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/routes/app_router.gr.dart';
import 'package:wmd/features/splash/presentation/manager/splash_cubit.dart';
import 'package:wmd/injection_container.dart';

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
        listener: (context, state) {
          if(state is SplashLoaded){
            context.router.replaceNamed(state.routeName);
          }
        },
        child: Scaffold(
          body: LayoutBuilder(
              builder: (context, snapShot) {
                return Center(
                  child: Image.asset(
                    "assets/images/logo.png", width: snapShot.maxWidth * 0.7,),
                );
              }
          ),
        ),
      ),
    );
  }
}
