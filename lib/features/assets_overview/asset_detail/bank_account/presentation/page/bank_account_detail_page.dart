import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/presentation/manager/bank_account_cubit.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/presentation/widget/bank_account_detail.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';
import 'package:wmd/injection_container.dart';

class BankAccountDetailsPage extends AppStatelessWidget {
  final String assetId;
  final String type;
  const BankAccountDetailsPage(
      {Key? key, required this.assetId, required this.type})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank account details'),
      ),
      body: BlocProvider(
        create: (context) =>
            sl<BankAccountCubit>()..getBankAccount(BankAccountParams(assetId)),
        child: BlocConsumer<BankAccountCubit, BankAccountState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {},
            ),
            builder: (context, state) {
              if (state is BankAccountLoaded) {
                return AssetDetailsWidget(bankAccount: state.bankAccount);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
