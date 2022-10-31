import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import 'package:wmd/injection_container.dart';

class VerifyResponsePage extends AppStatelessWidget {
  final Map<String, dynamic> verifyMap;

  const VerifyResponsePage({Key? key, required this.verifyMap})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<VerifyEmailCubit>()..verifyEmail(map: verifyMap),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
          builder: BlocHelper.defaultBlocBuilder(builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state is ErrorState
                        ? (state.failure.message.isEmpty
                            ? "error"
                            : state.failure.message)
                        : state is SuccessState
                    ? state.appSuccess.message : "response verify page"),
                    state is SuccessState ? ElevatedButton(onPressed: (){
                      context.goNamed(AppRoutes.dashboard);
                    }, child: Text("continue")) : ElevatedButton(onPressed: (){
                      context.goNamed(AppRoutes.welcome);
                    }, child: Text("try again"))
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
