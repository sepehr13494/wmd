import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/presentation/manager/plaid_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../domain/entity/bank_entity.dart';

class BankWidget extends StatefulWidget {
  const BankWidget(this.bank, {required super.key});
  final BankEntity bank;

  @override
  AppState<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends AppState<BankWidget> {
  bool isSelected = false;
  late final BankEntity bank;
  @override
  void initState() {
    super.initState();
    bank = widget.bank;
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Card(
        color: isSelected ? primaryColor.withOpacity(0.2) : null,
        child: ListTile(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          title: Text(bank.name),
          leading: bank.logo == null
              ? Icon(Icons.account_balance, color: primaryColor)
              : Image.network(bank.logo!),
          trailing: isSelected ? Connectbutton(bank) : null,
          selected: isSelected,
          selectedColor: null,
        ),
      ),
    );
  }
}

class Connectbutton extends AppStatelessWidget {
  final BankEntity bank;
  const Connectbutton(this.bank, {Key? key}) : super(key: key);

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
              return InkWell(
                onTap: () {
                  context.read<PlaidCubit>().linkPlaidAccount(bank);
                },
                child: _buildContainerWithborder(primaryColor, 'Connect'),
              );
            } else if (state is PlaidLinkSuccess) {
              return _buildContainerWithborder(primaryColor, 'Connected');
            } else {
              return _buildContainerWithborder(primaryColor, '...');
            }
          }),
    );
  }

  Container _buildContainerWithborder(Color borderColor, String message) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(message),
      ),
    );
  }
}
