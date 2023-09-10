import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/features/authentication/logout/presentation/manager/logout_cubit.dart';
import 'package:wmd/injection_container.dart';


class LogoutDialog extends AppStatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Dialog(
        child: BlocProvider(
          create: (context) => sl<LogoutCubit>(),
          child: Builder(
              builder: (context) {
                return BlocListener<LogoutCubit, BaseState>(
                  listener: BlocHelper.defaultBlocListener(listener: (context, state) {
                    if(state is SuccessState){
                      AppRestart.restart(context);
                    }
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(appLocalizations
                            .common_logoutConfirmationModal_title),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<LogoutCubit>().performLogout();
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 50)),
                              child: Text(
                                  appLocalizations.common_button_logout),
                            ),
                            const SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(100, 50)),
                              child: Text(
                                appLocalizations.common_button_cancel,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}
