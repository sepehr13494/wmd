import 'package:flutter/foundation.dart';
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
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/injection_container.dart';
import '../manager/custodian_bank_auth_cubit.dart';
import 'status_step_widget.dart';
import 'dart:io' show Platform;

showCustodianBankStatus({
  required BuildContext context,
  required String bankId,
  required String? id,
  void Function()? onOk,
}) async {
  final appLocalization = AppLocalizations.of(context);
  await showDialog(
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
            // cancelBtn: 'Cancel',
          ));
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      if (onOk != null) {
        onOk();
      }
    }
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
        sl<CustodianStatusListCubit>().getCustodianStatusList();
      }
    }, builder: (context, state) {
      if (state is ErrorState) {
        return Text(state.failure.message);
      } else if (state is CustodianBankStateLoaded) {
        final status = state.custodianBankStatusEntity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.linkAccount_stepper_heading.replaceFirstMapped(
                  '{{bankName}}', (match) => status.bankName),
              // 'Link your ${status.bankName} bank account',
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              appLocalizations.linkAccount_stepper_description,
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            StatusStepWidget(
              stepNumber: '1',
              title: appLocalizations.linkAccount_stepper_stepOne_title,
              trailing: '5 ${appLocalizations.common_labels_mins}',
              subtitle:
                  appLocalizations.linkAccount_stepper_stepOne_action_active,
              doneSubtitle:
                  appLocalizations.linkAccount_stepper_stepOne_action_completed,
              isDone: status.signLetter,
              onDone: (val) async {
                downloadPdf(status);
                context.read<CustodianBankAuthCubit>().postCustodianBankStatus(
                    PostCustodianBankStatusParams(
                        bankId: widget.bankId,
                        signLetter: true,
                        shareWithBank: false,
                        bankConfirmation: false));

                await AnalyticsUtils.triggerEvent(
                    action: AnalyticsUtils.linkBankStep2Action(status.bankName),
                    params: AnalyticsUtils.linkBankStep2Event(status.bankName));

                context.goNamed(AppRoutes.main,
                    queryParams: {'expandCustodian': "true"});
              },
              onDoneAgain: () {
                downloadPdf(status);

                // context
                //     .read<CustodianBankAuthCubit>()
                //     .postCustodianBankStatus(PostCustodianBankStatusParams(
                //         bankId: widget.bankId,
                //         signLetter: false,
                //         shareWithBank: false,
                //         bankConfirmation: false));
              },
            ),
            StatusStepWidget(
              stepNumber: '2',
              title: appLocalizations.linkAccount_stepper_stepTwo_title,
              trailing: '2 ${appLocalizations.assets_charts_days}',
              showInput: true,
              subtitle: (status.signLetter && !status.shareWithBank)
                  ? appLocalizations.linkAccount_stepper_stepTwo_action_active
                  : null,
              isDone: status.shareWithBank,
              onDone: (val) async {
                context.read<CustodianBankAuthCubit>().postCustodianBankStatus(
                    PostCustodianBankStatusParams(
                        bankId: widget.bankId,
                        id: id,
                        accountId: val,
                        signLetter: true,
                        shareWithBank: true,
                        bankConfirmation: false));

                await AnalyticsUtils.triggerEvent(
                    action: AnalyticsUtils.linkBankStep3Action(status.bankName),
                    params: AnalyticsUtils.linkBankStep3Event(status.bankName));
              },
            ),
            StatusStepWidget(
              stepNumber: '3',
              title: appLocalizations.linkAccount_stepper_stepThree_title,
              trailing: '5-10 ${appLocalizations.assets_charts_days}',
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CustodianBankStateLoaded) {
            final status = state.custodianBankStatusEntity;

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if (status.shareWithBank && AppConstants.publicMvp2Items)
                    TextButton(
                        onPressed: () {
                          // context.pushNamed(AppRoutes.forgetPassword);
                        },
                        child: Text(
                          appLocalizations.common_button_delete,
                          style: textTheme.bodySmall!.toLinkStyle(context),
                        )),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    child: Text(appLocalizations.common_button_ok),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    child: Text(appLocalizations.common_button_ok),
                  ),
                ],
              ),
            );
          }
        });
  }
}
