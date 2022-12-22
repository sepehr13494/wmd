import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/injection_container.dart';
import '../manager/custodian_bank_auth_cubit.dart';
import 'status_step_widget.dart';

showCustodianBankStatus({
  required BuildContext context,
  required String bankId,
  void Function()? onOk,
}) async {
  final appLocalization = AppLocalizations.of(context);
  await showDialog(
    context: context,
    builder: (context) {
      return BottomModalWidget(
        confirmBtn: 'Ok',
        body: BankStatusModalBody(bankId: bankId),
        // cancelBtn: 'Cancel',
      );
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
  }) : super(key: key);

  final String bankId;

  @override
  AppState<BankStatusModalBody> createState() => _BankStatusModalBodyState();
}

class _BankStatusModalBodyState extends AppState<BankStatusModalBody> {
  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CustodianBankAuthCubit>()
        ..getCustodianBankStatus(
            GetCustodianBankStatusParams(bankId: widget.bankId)),
      child: BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
          listener: (context, state) {
        if (state is CustodianBankStateUpdated) {
          context.read<CustodianBankAuthCubit>().getCustodianBankStatus(
              GetCustodianBankStatusParams(bankId: widget.bankId));
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
                'Link your ${status.bankName} bank account',
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Now you can proceed with linking your bank account following the steps below ',
                style: textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              StatusStepWidget(
                stepNumber: '1',
                title: 'Sign letter of authorization',
                trailing: '5 mins',
                subtitle: 'Download and sign letter',
                doneSubtitle: 'Download again',
                isDone: status.signLetter,
                onDone: () {
                  launchUrlString(status.signLetterLink);
                  context
                      .read<CustodianBankAuthCubit>()
                      .postCustodianBankStatus(PostCustodianBankStatusParams(
                          bankId: widget.bankId,
                          signLetter: true,
                          shareWithBank: false,
                          bankConfirmation: false));
                },
                onDoneAgain: () {
                  launchUrlString(status.signLetterLink);
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
                title: 'Share with the bank',
                trailing: '2 days',
                subtitle: (status.signLetter && !status.shareWithBank)
                    ? 'Mark as completed'
                    : null,
                isDone: status.shareWithBank,
                onDone: () {
                  context
                      .read<CustodianBankAuthCubit>()
                      .postCustodianBankStatus(PostCustodianBankStatusParams(
                          bankId: widget.bankId,
                          signLetter: true,
                          shareWithBank: true,
                          bankConfirmation: false));
                },
              ),
              StatusStepWidget(
                stepNumber: '3',
                title: 'Get confirmation from bank via your RM',
                trailing: '5-10 days',
                isDone: status.bankConfirmation,
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
