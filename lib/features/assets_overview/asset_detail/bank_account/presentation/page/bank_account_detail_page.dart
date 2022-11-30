import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/presentation/manager/bank_account_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';
import 'package:wmd/injection_container.dart';

class BankAccountDetailPage extends AppStatelessWidget {
  final AssetList asset;
  const BankAccountDetailPage({Key? key, required this.asset})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank account details'),
      ),
      body: BlocProvider(
        create: (context) => sl<BankAccountCubit>()
          ..getBankAccount(BankAccountParams(asset.assetId)),
        child: BlocConsumer<BankAccountCubit, BankAccountState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {},
            ),
            builder: (context, state) {
              if (state is BankAccountLoaded) {
                return Text(state.bankAccount.toString());
              }
              return const Card(
                child: ListTile(
                  title: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
