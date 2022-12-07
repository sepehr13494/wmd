import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_bank_widget.dart';
import 'package:wmd/injection_container.dart';

class AddCustodianBanksPage extends AppStatelessWidget {
  const AddCustodianBanksPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CustodianBankAuthCubit>()..getCustodianBankList(),
      child: BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text("Link you bank accounts", style: textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text("Select bank", style: textTheme.titleMedium),
              Builder(builder: (context) {
                if (state is CustodianBankListLoaded) {
                  return Column(
                    children: state.getCustodianBankListEntity
                        .map((e) => CustodianBankWidget(e, key: Key(e.bankId)))
                        .toList(),
                  );
                }
                return Container();
              })
            ],
          );
        },
      ),
    );
  }
}
