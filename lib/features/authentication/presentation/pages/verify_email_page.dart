import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/presentation/widgets/timer_widget.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class VerifyEmailPage extends AppStatelessWidget {
  final RegisterParams registerParams;
  const VerifyEmailPage({Key? key, required this.registerParams})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: WidthLimiterWidget(
            child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is SuccessState) {
              GlobalFunctions.showSnackBar(
                context,
                'Magic link sent again to your email',
              );
            }
          }),
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textTheme.bodySmall!.color!.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                ),
                Text(
                  appLocalizations.sign_up_verify_email_title,
                  style: textTheme.headlineSmall,
                ),
                Text(
                  appLocalizations.sign_up_verify_email_title_description
                      .replaceFirst("%s", registerParams.email),
                  style: textTheme.bodyMedium!.copyWith(height: 1.3),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(),
                TimerWidget(sendCodeAgain: () {
                  context
                      .read<AuthenticationCubit>()
                      .postRegister(map: registerParams.toJson());
                }),
                const Spacer(),
                const Divider(),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(height: 1.3),
                        children: [
                      TextSpan(
                          text: "${appLocalizations.already_have_account} ",
                          style: textTheme.bodySmall),
                      TextSpan(
                        text: appLocalizations.login,
                        style: textTheme.bodySmall!.toLinkStyle(context),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(AppRoutes.login);
                          },
                      ),
                    ])),
                const SizedBox(height: 24)
              ]
                  .map((e) => e is Spacer
                      ? e
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: e,
                        ))
                  .toList(),
            );
          },
        )),
      ),
    );
  }
}
