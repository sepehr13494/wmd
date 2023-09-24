import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_bank_widget.dart';
import 'package:wmd/features/add_assets/pam_login/presentation/widgets/pam_custodian_bank_widget.dart';
import 'package:wmd/injection_container.dart';

import '../../../tfo_login/presentation/widgets/tfo_custodian_bank_widget.dart';
import '../../../request_new_custodian/presentation/widget/new_custodian_request_modal.dart';

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
    const tfoKey = "TFO";
    const pamKey = "PAM";
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
              Text(appLocalizations.linkAccount_automaticLink_label_search,
                  style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                if (state is CustodianBankListLoaded) {
                  if (state.custodianBankList.isEmpty) {
                    return Text(
                        appLocalizations.manage_automaticLink_text_notFound);
                  }
                  return Column(
                    children: [
                      TfoCustodianBankWidget(
                        key: const Key(tfoKey),
                        onActive: () {
                          setState(() {
                            selectedBankId = tfoKey;
                          });
                        },
                        isSelected: selectedBankId == tfoKey,
                      ),
                      PamCustodianBankWidget(
                        key: const Key(pamKey),
                        onActive: () {
                          setState(() {
                            selectedBankId = pamKey;
                          });
                        },
                        isSelected: selectedBankId == pamKey,
                      ),
                      ...state.custodianBankList
                          .map((e) => CustodianBankWidgetV2(
                                bank: e,
                                key: Key(e.bankId),
                                onActive: () {
                                  setState(() {
                                    selectedBankId = e.bankId;
                                  });
                                },
                                isSelected: selectedBankId == e.bankId,
                              )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: OutlinedButton(
                            onPressed: () {
                              showNewCustodianModal(context: context);
                            },
                            child: Text(appLocalizations
                                .common_newCustodianRequest_modal_button)),
                      ),
                      const SizedBox(
                        height: 82,
                      )
                    ],
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
