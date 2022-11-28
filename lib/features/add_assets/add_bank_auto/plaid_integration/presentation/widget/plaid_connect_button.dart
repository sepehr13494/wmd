import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/presentation/manager/plaid_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/injection_container.dart';

class PlaidConnectButton extends AppStatelessWidget {
  final BankEntity bank;
  const PlaidConnectButton(this.bank, {Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocProvider(
      create: (context) => sl<PlaidCubit>(),
      child: BlocConsumer<PlaidCubit, PlaidState>(
          listener:
              BlocHelper.defaultBlocListener(listener: (context, state) {}),
          builder: (context, state) {
            if (state is PlaidInitialState || state is ErrorState) {
              //Should handle initial state
              // return InkWell(
              //   onTap: () {
              //     context.read<PlaidCubit>().linkPlaidAccount(bank);
              //   },
              //   child: _buildContainerWithborder('Connect', primaryColor),
              // );
              return _buildContainerWithborder('Connect');
            } else if (state is PlaidLinkSuccess) {
              return _buildContainerWithborder('Connected');
            } else {
              return _buildContainerWithborder('...');
            }
          }),
    );
  }

  Container _buildContainerWithborder(String message, [Color? borderColor]) {
    return Container(
      decoration: BoxDecoration(
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(message),
      ),
    );
  }
}
