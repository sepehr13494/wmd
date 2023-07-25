import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/put_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import '../manager/custodian_bank_auth_cubit.dart';
import 'status_step_widget.dart';
import 'dart:io' show Platform;

Future<bool> showCustodianBankStatus({
  required BuildContext context,
  required String bankId,
  required String? id,
  void Function()? onOk,
  Future<dynamic> Function()? onDelete,
}) async {
  final appLocalization = AppLocalizations.of(context);
  return await showDialog(
    context: context,
    builder: (context) {
      return BlocProvider(
          create: (context) => sl<CustodianBankAuthCubit>()
            ..getCustodianBankStatus(GetCustodianBankStatusParams(
                bankId: bankId, custodianBankStatusId: id)),
          child: CenterModalWidget(
              confirmBtn: appLocalization.common_button_ok,
              body: BankStatusModalBody(bankId: bankId, id: id),
              actions: const ActionContainer(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0)
              // cancelBtn: 'Cancel',
              ));
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      if (onOk != null) {
        onOk();
      }
    }
    if (isConfirm != null && isConfirm == "delete") {
      return true;
    }

    return false;
  });
}

class BankStatusModalBody extends StatefulWidget {
  const BankStatusModalBody({
    Key? key,
    required this.bankId,
    required this.id,
  }) : super(key: key);

  final String bankId;
  final String? id;

  @override
  AppState<BankStatusModalBody> createState() => _BankStatusModalBodyState();
}

class _BankStatusModalBodyState extends AppState<BankStatusModalBody> {
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
        listener: (context, state) {
      if (state is CustodianBankStateUpdated) {
        id = state.postCustodianBankStatusEntity.id;
        context.read<CustodianBankAuthCubit>().getCustodianBankStatus(
            GetCustodianBankStatusParams(
                bankId: widget.bankId, custodianBankStatusId: id));
        // sl<CustodianStatusListCubit>().getCustodianStatusList();
      } else if (state is ErrorState) {
        final String error = state.failure.data['title'] ==
                'There is already a custodian bank status with same bank and account for the user'
            ? appLocalizations.linkAccount_errors_existingCIF
            : appLocalizations.common_errors_somethingWentWrong;
        Flushbar(
          message: error,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          icon: const Icon(
            Icons.info_outline,
            size: 14,
            color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
        ).show(context);
        context.read<CustodianBankAuthCubit>().getCustodianBankStatus(
            GetCustodianBankStatusParams(
                bankId: widget.bankId, custodianBankStatusId: id));
      }
    }, builder: (context, state) {
      if (state is CustodianBankStateLoaded) {
        final status = state.custodianBankStatusEntity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.linkAccount_stepper_heading.replaceFirstMapped(
                  '{{bankName}}', (match) => status.bankName),
              // 'Link your ${status.bankName} bank account',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Complete the following steps to link your bank account',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            CifStatusWidget(
              stepNumber: '1',
              bankId: widget.bankId,
              title: 'Enter the custodian account number',
              trailing: '2 ${appLocalizations.assets_charts_days}',
              // showInput: true,
              subtitle: status.accountId != null
                  ? appLocalizations
                      .linkAccount_stepper_stepTwo_action_completed
                  : 'Mark as done',
              accountId: status.accountId,
              // isDone: status.shareWithBank,
              ready: status.signLetter,
              onDone: status.accountId != null
                  ? null
                  : (val) async {
                      context
                          .read<CustodianBankAuthCubit>()
                          .putCustodianBankStatus(PutCustodianBankStatusParams(
                              bankId: widget.bankId,
                              id: id,
                              accountId: val,
                              signLetter: true,
                              shareWithBank: true,
                              bankConfirmation: false));

                      await AnalyticsUtils.triggerEvent(
                          action: AnalyticsUtils.linkBankStep3Action(
                              status.bankName),
                          params: AnalyticsUtils.linkBankStep3Event(
                              status.bankName));
                    },
            ),
            StatusStepWidget(
              stepNumber: '2',
              title: 'Download the authorization letter',
              // trailing: '5 ${appLocalizations.common_labels_mins}',
              subtitle: Text(
                appLocalizations.linkAccount_stepper_stepOne_action_active,
                style: textTheme.bodySmall!.apply(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline),
              ),
              doneSubtitle:
                  appLocalizations.linkAccount_stepper_stepOne_action_completed,
              isDone: status.signLetter,
              onDone: (val) async {
                final isDone = downloadPdf(status);
                context.read<CustodianBankAuthCubit>().postCustodianBankStatus(
                    PostCustodianBankStatusParams(
                        bankId: widget.bankId,
                        signLetter: true,
                        shareWithBank: false,
                        bankConfirmation: false));

                await AnalyticsUtils.triggerEvent(
                    action: AnalyticsUtils.linkBankStep2Action(status.bankName),
                    params: AnalyticsUtils.linkBankStep2Event(status.bankName));
                await isDone;

                // // ignore: use_build_context_synchronously
                // context.goNamed(AppRoutes.main,
                //     queryParams: {'expandCustodian': "true"});
              },
              onDoneAgain: () {
                downloadPdf(status);
              },
            ),
            StatusStepWidget(
              stepNumber: '3',
              title: 'Print, fill and sign authorization letter',
              // trailing: '5-10 ${appLocalizations.assets_charts_days}',
              isDone: status.bankConfirmation,
            ),
            StatusStepWidget(
              stepNumber: '4',
              title: 'Share the letter with your custodian bank',
              trailing: Column(
                children: [
                  Text('shared on',
                      style: textTheme.bodySmall?.copyWith(
                          fontSize: 10, color: Theme.of(context).primaryColor)),
                  Text(' 05/12/23',
                      style: textTheme.bodySmall?.copyWith(
                          fontSize: 10, color: Theme.of(context).primaryColor)),
                ],
              ),
              isDone: status.bankConfirmation,
            ),
            StatusStepWidget(
              stepNumber: '5',
              title: 'Awaiting data from your custodian bank',
              subtitle: Text(
                'It may take up to 10 working days. You will be emailed when the data is received.',
                style: textTheme.bodySmall,
              ),
              isDone: status.bankConfirmation,
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Future<bool> downloadPdf(CustodianBankStatusEntity status) {
    if (Platform.isAndroid) {
      return launchUrlString(
        status.signLetterLink,
        mode: LaunchMode.externalApplication,
      );
    } else {
      return launchUrlString(status.signLetterLink);
    }
  }
}

class ActionContainer extends AppStatelessWidget {
  const ActionContainer({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
        listener: (context, state) {
      if (state is SuccessState) {
        Navigator.pop(context, "delete");
      }
    }, builder: (context, state) {
      if (state is CustodianBankStateLoaded) {
        final status = state.custodianBankStatusEntity;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              if (status.signLetter)
                Visibility(
                  visible: false,
                  child: TextButton(
                      onPressed: () async {
                        final result = await GlobalFunctions.confirmProcess(
                            context: context,
                            title: appLocalizations
                                .linkAccount_deleteCustodianBankModal_description,
                            yes: appLocalizations
                                .linkAccount_deleteCustodianBankModal_yes,
                            no: appLocalizations
                                .linkAccount_deleteCustodianBankModal_no,
                            body: "");

                        if (result) {
                          context
                              .read<CustodianBankAuthCubit>()
                              .deleteCustodianBankStatus(
                                  DeleteCustodianBankStatusParams(
                                      id: status.id));
                        }

                        // context.pushNamed(AppRoutes.forgetPassword);
                      },
                      child: Text(
                        appLocalizations.common_button_delete,
                        style: textTheme.bodySmall!.toLinkStyle(context),
                      )),
                ),
              // const SizedBox(width: 16),
              // ElevatedButton(
              //   onPressed: () => Navigator.pop(context, true),
              //   style:
              //       ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
              //   child: Text(appLocalizations.common_button_ok),
              // ),
            ],
          ),
        );
      } else {
        return const SizedBox();
        // return Padding(
        //   padding: const EdgeInsets.all(24.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     // mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const SizedBox(width: 16),
        //       ElevatedButton(
        //         onPressed: () => Navigator.pop(context, true),
        //         style:
        //             ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
        //         child: Text(appLocalizations.common_button_ok),
        //       ),
        //     ],
        //   ),
        // );
      }
    });
  }
}
