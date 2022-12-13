import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';
import 'package:wmd/injection_container.dart';

import '../manager/custodian_bank_auth_cubit.dart';
import 'status_step_widget.dart';

showCustodianBankStatus({
  required BuildContext context,
  required CustodianBankEntity bank,
}) async {
  final appLocalization = AppLocalizations.of(context);
  await showDialog(
    context: context,
    builder: (context) {
      return BottomModalWidget(
        confirmBtn: 'Ok',
        body: BankStatusModalBody(bank: bank),
        // cancelBtn: 'Cancel',
      );
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      // onExitClick();
    }
  });
}

class BankStatusModalBody extends StatefulWidget {
  const BankStatusModalBody({
    Key? key,
    required this.bank,
  }) : super(key: key);

  final CustodianBankEntity bank;

  @override
  AppState<BankStatusModalBody> createState() => _BankStatusModalBodyState();
}

class _BankStatusModalBodyState extends AppState<BankStatusModalBody> {
  bool haveTried = false;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CustodianBankAuthCubit>()
        ..getCustodianBankStatus(
            GetCustodianBankStatusParams(bankId: widget.bank.bankId)),
      child: BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
          listener: (context, state) {
        if (state is ErrorState) {
          // if (!haveTried) {
          //   context.read<CustodianBankAuthCubit>().postCustodianBankStatus(
          //       PostCustodianBankStatusParams.fromEntity(widget.bank));
          //   haveTried = true;
          // }
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
                'Link your Credit Suisse bank account',
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
                onDone: () {},
                onDoneAgain: () {},
              ),
              StatusStepWidget(
                stepNumber: '2',
                title: 'Share with the bank',
                trailing: '2 days',
                subtitle: (status.signLetter && !status.shareWithBank)
                    ? 'Mark as completed'
                    : null,
                isDone: status.shareWithBank,
                onDone: () {},
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
