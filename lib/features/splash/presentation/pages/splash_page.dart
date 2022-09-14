import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/routes/app_router.gr.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),() {
      context.router.push(MyHomeRoute());
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context,snapShot) {
            return Center(
              child: Image.asset("assets/images/logo.png",width: snapShot.maxWidth*0.7,),
            );
          }
      ),
    );
  }
}
