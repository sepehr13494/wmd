import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_params.dart';
import 'package:wmd/features/add_assets/tfo_login/presentation/widgets/tfo_confirm_mandate_modal.dart';
import 'package:wmd/features/add_assets/tfo_login/presentation/widgets/tfo_success_modal.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

import '../manager/tfo_login_cubit.dart';
import 'mandate_wrapper.dart';

class TfoCustodianBankWidget extends AppStatelessWidget {
  const TfoCustodianBankWidget(
      {super.key, required this.isSelected, required this.onActive});

  final bool isSelected;
  final void Function() onActive;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    return MandateWrapper(builder: (context, mandateList) {
      return BlocProvider(
        create: (context) => sl<TfoLoginCubit>(),
        child: BlocConsumer<TfoLoginCubit, TfoLoginState>(
            listener: (context, state) async {
          if (state is SuccessState) {
            GlobalFunctions.showSnackTile(context,
                title: appLocalizations.common_linkTFO_toast_success_title,
                subtitle:
                    appLocalizations.common_linkTFO_toast_success_description,
                color: Colors.green);
            context.goNamed(AppRoutes.main,
                queryParams: {'expandCustodian': "true"});
            context.read<MandateStatusCubit>().getMandateStatus();
          } else if (state is TfoMandatesLoaded) {
            final filteredList = state.mandates
                .where((e) =>
                    !mandateList.map((e) => e.mandateId).contains(e.mandateId))
                .toList();
            if (filteredList.isEmpty) {
              GlobalFunctions.showSnackTile(context,
                  title:
                      appLocalizations.common_linkTFO_toast_alreadyLinked_title,
                  subtitle: appLocalizations
                      .common_linkTFO_toast_alreadyLinked_description,
                  color: Colors.red);
              // context.goNamed(AppRoutes.main,
              //     queryParams: {'expandCustodian': "true"});
            } else if (filteredList.length == 1) {
              final res = await showTfoSuccessModal(context: context);
              if (res) {
                // ignore: use_build_context_synchronously
                context
                    .read<TfoLoginCubit>()
                    .postMandates(LoginTfoAccountParams(filteredList));
              }
            } else {
              final selected = await showTfoConfirmMandateModal(
                  context: context, mandates: filteredList);
              if (selected != null && selected.isNotEmpty) {
                // ignore: use_build_context_synchronously
                context
                    .read<TfoLoginCubit>()
                    .postMandates(LoginTfoAccountParams(selected));
              }
            }
          } else if (state is ErrorState) {
            GlobalFunctions.showSnackTile(context,
                title: appLocalizations.common_linkAuth0_userCancelled,
                color: Colors.red);
          }
        }, builder: (context, state) {
          bool isLoading = state is LoadingState;
          bool isDone = state is SuccessState;
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
                title: const Text('The Family Office'),
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
                                          'The Office Family custodian'),
                                      params: AnalyticsUtils.linkBankEvent(
                                          'The Office Family custodian')); // ignore: use_build_context_synchronously
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<TfoLoginCubit>()
                                      .loginTfoAccount();
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
    });
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
