import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/local_auth_manager.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({Key? key}) : super(key: key);

  @override
  AppState<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends AppState<LocalAuthPage> {

  @override
  void didChangeDependencies() {
    _checkAuth();
    super.didChangeDependencies();
  }

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
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
    if(localAuthManager.state){
      final didAuth = await localAuthManager.authenticate(context);
      if(didAuth){
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }else{
        // ignore: use_build_context_synchronously
        context.goNamed(AppRoutes.login);
      }
    }else{
      Navigator.pop(context);
    }
  }
}
