import 'package:flutter/material.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthAppBar(),
      body: Center(child: Text(title),),
    );
  }
}
