import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
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
      create: (context) =>
      sl<VerifyEmailCubit>()
        ..verifyEmail(map: verifyMap),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
          builder: BlocHelper.defaultBlocBuilder(builder: (context, state) {
            return Center(child: Text(state is ErrorState ? state.failure.message :"response verify page"),);
          }),
        ),
      ),
    );
  }
}
