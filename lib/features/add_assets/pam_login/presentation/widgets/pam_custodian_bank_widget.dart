import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/pam_login/data/models/login_pam_account_params.dart';
import 'package:wmd/features/add_assets/pam_login/presentation/widgets/pam_confirm_mandate_modal.dart';
import 'package:wmd/features/add_assets/pam_login/presentation/widgets/pam_success_modal.dart';
import 'package:wmd/features/add_assets/tfo_login/presentation/widgets/initial_modal.dart';
import 'package:wmd/features/add_assets/tfo_login/presentation/widgets/tfo_success_modal.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

import '../manager/pam_login_cubit.dart';

class PamCustodianBankWidget extends AppStatelessWidget {
  const PamCustodianBankWidget(
      {super.key, required this.isSelected, required this.onActive});

  final bool isSelected;
  final void Function() onActive;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    return BlocProvider(
      create: (context) => sl<PamLoginCubit>(),
      child: BlocConsumer<PamLoginCubit, PamLoginState>(listener:
          BlocHelper.defaultBlocListener(listener: (context, state) async {
        if (state is SuccessState) {
          // showTfoConfirmMandateModal(context: context);
          // showTfoSuccessModal(context: context);
        } else if (state is MandatesLoaded) {
          if (state.mandates.length == 1) {
            final res = await showPamSuccessModal(context: context);
            if (res) {
              context
                  .read<PamLoginCubit>()
                  .postMandates(LoginPamAccountParams(state.mandates));
            }
          } else {
            showPamConfirmMandateModal(
                context: context, mandates: state.mandates);
          }
        } else if (state is ErrorState) {
          GlobalFunctions.showSnackTile(context,
              title: appLocalizations.common_toast_generic_error_title,
              color: Colors.red);
        }
      }), builder: (context, state) {
        bool isLoading = state is LoadingState;
        bool isDone = state is SuccessState;
        // bool isDone = state is SuccessState || state is MandatesLoaded;
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: isSelected ? primaryColor.withOpacity(0.2) : null,
            child: ListTile(
              onTap: () {
                onActive();
              },
              title: const Text('Petiole Asset Management'),
              leading: Icon(Icons.account_balance, color: primaryColor),
              trailing: isDone
                  ? _buildButton(context,
                      appLocalizations.linkAccount_stepper_label_completed)
                  : !isSelected
                      ? null
                      : Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () async {
                                await AnalyticsUtils.triggerEvent(
                                    action: AnalyticsUtils.linkBankAction(
                                        'Pam custodian'),
                                    params: AnalyticsUtils.linkBankEvent(
                                        'Pam custodian'));
                                final result = await showInitialModal(
                                  context: context,
                                  title:
                                      'Do you want to load you existing PAM portfolio?',
                                );
                                if (result) {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<PamLoginCubit>()
                                      .loginPamAccount();
                                }
                              },
                              child: _buildButton(context,
                                  appLocalizations.common_button_connect),
                            );
                          },
                        ),
              selected: isSelected,
              selectedColor: null,
            ),
          ),
        );
      }),
    );
  }

  Container _buildButton(BuildContext context, String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(text),
      ),
    );
  }
}
