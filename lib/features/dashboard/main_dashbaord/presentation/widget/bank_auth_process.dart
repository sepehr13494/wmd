import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';
import 'package:wmd/injection_container.dart';

class BanksAuthorizationProcess extends AppStatelessWidget {
  const BanksAuthorizationProcess({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CustodianBankAuthCubit>()..getCustodianBankList(),
      child: BlocConsumer<CustodianBankAuthCubit, CustodianBankAuthState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: (context, state) {
          if (state is CustodianBankListLoaded) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your banks authorization process',
                        style: textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FractionColumnWidth(0.25),
                          1: FractionColumnWidth(0.25),
                          3: FractionColumnWidth(0.5),
                        },
                        children: [
                          buildTableHeader(textTheme),
                          ...state.getCustodianBankListEntity
                              .map((e) => buildTableRow(context, e, textTheme))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  TableRow buildTableHeader(TextTheme textTheme,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(vertical: 8.0)}) {
    return TableRow(
      children: [
        Padding(
          padding: padding,
          child: Text(
            'Bank Name',
            style: textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            'Status',
            style: textTheme.bodySmall,
          ),
        ),
        const SizedBox.shrink()
      ],
    );
  }

  TableRow buildTableRow(
      BuildContext context, CustodianBankEntity e, TextTheme textTheme,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(vertical: 8.0)}) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),
      children: [
        Padding(
          padding: padding,
          child: Text(
            e.bankName,
            style: textTheme.labelMedium,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(e.bankId, style: textTheme.labelMedium),
        ),
        Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                showCustodianBankStatus(context: context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'View',
                    style: textTheme.bodySmall!.apply(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 8,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
