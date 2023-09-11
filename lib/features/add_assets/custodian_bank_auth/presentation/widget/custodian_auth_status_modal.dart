import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
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
  bool isThreeStep = false;

  @override
  void initState() {
    super.initState();
    id = widget.id;

    setState(() {
      isThreeStep = widget.bankId == "ubp";
    });
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
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              appLocalizations.linkAccount_stepper_description,
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            CifStatusWidget(
              stepNumber: '1',
              bankId: widget.bankId,
              title: appLocalizations.linkAccount_stepper_stepOne_title,
              trailing: '2 ${appLocalizations.assets_charts_days}',
              // showInput: true,
              subtitle:
                  appLocalizations.linkAccount_stepper_stepOne_action_active,
              accountId: status.accountNumber,
              isDone: checkCurrentCustodianStatusDone(
                  CustodianStatus.FillAccount, status.status),
              isActive: checkCurrentCustodianStatus(
                  CustodianStatus.FillAccount, status.status),
              // ready: status.signLetter,
              onDone: (val) async {
                context
                    .read<CustodianBankAuthCubit>()
                    .postCustodianBankStatus(PostCustodianBankStatusParams(
                      bankId: widget.bankId,
                      status: CustodianStatus.OpenLetter,
                      accountNumber: val,
                    ));

                await AnalyticsUtils.triggerEvent(
                    action: AnalyticsUtils.custodianStatusModalStep1,
                    params: AnalyticsUtils.custodianStatusModalStep1Event(val));
              },
              onEdit: (val) async {
                context.read<CustodianBankAuthCubit>().putCustodianBankStatus(
                    PutCustodianBankStatusParams(
                        id: status.id,
                        bankId: widget.bankId,
                        status: status.status,
                        accountNumber: val));

                await AnalyticsUtils.triggerEvent(
                    action: AnalyticsUtils.custodianStatusModalStep1,
                    params: AnalyticsUtils.custodianStatusModalStep1Event(val));
              },
            ),
            if (isThreeStep)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusStepWidget(
                    stepNumber: '2',
                    title: Text(
                      appLocalizations
                          .linkAccount_stepper_swisBankSteps_stepTwo_title
                          .replaceFirstMapped(
                              '{{bankName}}', (match) => status.bankName),
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          appLocalizations
                              .linkAccount_stepper_swisBankSteps_stepTwo_description
                              .replaceFirstMapped(
                                  '{{bankName}}', (match) => status.bankName),
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                appLocalizations
                                    .linkAccount_stepper_swisBankSteps_stepTwo_address_line1,
                                style: textTheme.bodySmall),
                            Text(
                                appLocalizations
                                    .linkAccount_stepper_swisBankSteps_stepTwo_address_line2,
                                style: textTheme.bodySmall),
                            Text(
                                appLocalizations
                                    .linkAccount_stepper_swisBankSteps_stepTwo_address_line3,
                                style: textTheme.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(height: 1.3),
                                children: [
                              TextSpan(
                                text: "Copy address",
                                style: textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Clipboard.setData(const ClipboardData(
                                            text:
                                                "All-In-One-Plus AG \nc/o Altenburger Ltd legal + tax, Seestrasse 39 \n8700 Küsnacht, Switzerlandmay"))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(appLocalizations
                                                  .linkAccount_stepper_swisBankSteps_stepTwo_toast_message)));
                                    });
                                  },
                              ),
                            ])),
                      ],
                    ),
                    showAction: true,
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.OpenLetter, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.OpenLetter, status.status),
                    onDone: (val) async {
                      context
                          .read<CustodianBankAuthCubit>()
                          .putCustodianBankStatus(PutCustodianBankStatusParams(
                              id: status.id,
                              bankId: widget.bankId,
                              status: CustodianStatus.SyncBank,
                              accountNumber: status.accountNumber));

                      await AnalyticsUtils.triggerEvent(
                          action: AnalyticsUtils.custodianStatusModalStep4,
                          params: AnalyticsUtils.custodianStatusModalStep4Event(
                              status.bankName));
                    },
                  ),
                  StatusStepWidget(
                    stepNumber: '3',
                    title: Text(
                      appLocalizations
                          .linkAccount_stepper_swisBankSteps_stepThree_title,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.SyncBank, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.SyncBank, status.status),
                  ),
                ],
              ),
            if (!isThreeStep)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusStepWidget(
                    stepNumber: '2',
                    title: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            "${appLocalizations.linkAccount_stepper_stepTwo_open} ",
                        style: textTheme.bodySmall?.copyWith(
                            color: checkCurrentCustodianStatus(
                                    CustodianStatus.OpenLetter, status.status)
                                ? Theme.of(context).primaryColor
                                : Colors.grey[500]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = checkCurrentCustodianStatus(
                                  CustodianStatus.OpenLetter, status.status)
                              ? () async {
                                  final isDone =
                                      downloadPdf(status.signLetterLink);

                                  context
                                      .read<CustodianBankAuthCubit>()
                                      .putCustodianBankStatus(
                                          PutCustodianBankStatusParams(
                                              id: status.id,
                                              bankId: widget.bankId,
                                              status:
                                                  CustodianStatus.FillLetter,
                                              accountNumber:
                                                  status.accountNumber));

                                  await AnalyticsUtils.triggerEvent(
                                      action: AnalyticsUtils
                                          .custodianStatusModalStep2,
                                      params: AnalyticsUtils
                                          .custodianStatusModalStep2Event(
                                              status.bankName));
                                  await isDone;
                                }
                              : null,
                      ),
                      TextSpan(
                        text:
                            appLocalizations.linkAccount_stepper_stepTwo_title,
                        style:
                            textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                    ])),
                    subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                        child: Text(
                          appLocalizations
                              .linkAccount_stepper_stepTwo_viewTutorial,
                          style: textTheme.bodySmall!.apply(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),
                        )),
                    doneSubtitle: appLocalizations
                        .linkAccount_stepper_stepOne_action_completed,
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.OpenLetter, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.OpenLetter, status.status),
                    onDone: (val) async {
                      final isDone = downloadPdf(status.tutorialLink);

                      await AnalyticsUtils.triggerEvent(
                          action:
                              AnalyticsUtils.custodianStatusModalViewTutorial,
                          params: AnalyticsUtils
                              .custodianStatusModalViewTutorialEvent(
                                  status.bankName));
                      await isDone;
                    },
                    onDoneAgain: () {
                      downloadPdf(status.tutorialLink);
                    },
                  ),
                  StatusStepWidget(
                    stepNumber: '3',
                    title: Text(
                      appLocalizations.linkAccount_stepper_stepThree_title,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    showAction: true,
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.FillLetter, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.FillLetter, status.status),
                    onDone: (val) async {
                      context
                          .read<CustodianBankAuthCubit>()
                          .putCustodianBankStatus(PutCustodianBankStatusParams(
                              id: status.id,
                              bankId: widget.bankId,
                              status: CustodianStatus.ShareLetter,
                              accountNumber: status.accountNumber));

                      await AnalyticsUtils.triggerEvent(
                          action: AnalyticsUtils.custodianStatusModalStep3,
                          params: AnalyticsUtils.custodianStatusModalStep3Event(
                              status.bankName));
                    },
                  ),
                  StatusStepWidget(
                    stepNumber: '4',
                    title: Text(
                      appLocalizations.linkAccount_stepper_stepFour_title,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    showAction: true,
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.ShareLetter, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.ShareLetter, status.status),
                    trailing: Column(
                      children: [
                        Text(
                            appLocalizations
                                .linkAccount_stepper_stepFour_sharedOn,
                            style: textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                color: Theme.of(context).primaryColor)),
                        Text(
                            status.shareDate != null
                                ? CustomizableDateTime.ddMmYyyyWithSlash(
                                    status.shareDate ?? DateTime.now())
                                : "",
                            style: textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                    onDone: (val) async {
                      context
                          .read<CustodianBankAuthCubit>()
                          .putCustodianBankStatus(PutCustodianBankStatusParams(
                              id: status.id,
                              bankId: widget.bankId,
                              status: CustodianStatus.SyncBank,
                              accountNumber: status.accountNumber));

                      await AnalyticsUtils.triggerEvent(
                          action: AnalyticsUtils.custodianStatusModalStep4,
                          params: AnalyticsUtils.custodianStatusModalStep4Event(
                              status.bankName));
                    },
                  ),
                  StatusStepWidget(
                    stepNumber: '5',
                    title: Text(
                      appLocalizations.linkAccount_stepper_stepFive_title,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                    subtitle: checkCurrentCustodianStatus(
                            CustodianStatus.SyncBank, status.status)
                        ? Text(
                            appLocalizations
                                .linkAccount_stepper_stepFive_description,
                            style: textTheme.bodySmall,
                          )
                        : null,
                    isDone: checkCurrentCustodianStatusDone(
                        CustodianStatus.SyncBank, status.status),
                    isActive: checkCurrentCustodianStatus(
                        CustodianStatus.SyncBank, status.status),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 9),
                child: Column(
                  children: [
                    Text(
                      appLocalizations.linkAccount_stepper_footer_note1,
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      appLocalizations.linkAccount_stepper_footer_note2,
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))
          ],
        );
      } else {
        return const SizedBox(
            height: 400, child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  Future<bool> downloadPdf(String statusLetter) {
    if (Platform.isAndroid) {
      return launchUrlString(
        statusLetter,
        mode: LaunchMode.externalApplication,
      );
    } else {
      return launchUrlString(statusLetter);
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
              if (status.accountNumber != null)
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
