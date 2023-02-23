import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_bank_widget.dart';
import 'package:wmd/injection_container.dart';

class AddCustodianBanksPage extends StatefulWidget {
  const AddCustodianBanksPage({Key? key}) : super(key: key);

  @override
  AppState<AddCustodianBanksPage> createState() =>
      _AddCustodianBanksPageState();
}

class _AddCustodianBanksPageState extends AppState<AddCustodianBanksPage> {
  String? selectedBankId;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CustodianBankListCubit>()..getCustodianBankList(),
      child: BlocConsumer<CustodianBankListCubit, CustodianBankListState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(appLocalizations.linkAccount_automaticLink_title,
                  style: textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(appLocalizations.linkAccount_automaticLink_description,
                  style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                if (state is CustodianBankListLoaded) {
                  if (state.custodianBankList.isEmpty) {
                    return Text(
                        appLocalizations.manage_automaticLink_text_notFound);
                  }
                  return Column(
                    children: state.custodianBankList
                        .map((e) => CustodianBankWidgetV2(
                              bank: e,
                              key: Key(e.bankId),
                              onActive: () {
                                setState(() {
                                  selectedBankId = e.bankId;
                                });
                              },
                              isSelected: selectedBankId == e.bankId,
                            ))
                        .toList(),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })
            ],
          );
        },
      ),
    );
  }
}
