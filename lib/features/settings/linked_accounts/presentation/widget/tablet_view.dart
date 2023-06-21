import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/entities/get_mandate_status_entity.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';
import 'package:wmd/features/settings/linked_accounts/presentation/manager/linked_accounts_cubit.dart';

class LinkedTableTablet extends AppStatelessWidget {
  final List<GetLinkedAccountsEntity> getLinkedAccountsEntities;
  final List<GetMandateStatusEntity> mandateList;
  const LinkedTableTablet(
      {required this.getLinkedAccountsEntities,
      required this.mandateList,
      super.key});

  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
    2: FlexColumnWidth(),
    3: IntrinsicColumnWidth(),
    4: IntrinsicColumnWidth(),
  };

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    if (getLinkedAccountsEntities.isEmpty && mandateList.isEmpty) {
      return Text(appLocalizations.common_glossary_noDataFoundHeading);
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        _buildTableHeader(context, textTheme),
        ...List.generate(getLinkedAccountsEntities.length, (index) {
          return _buildTableRow(context, index,
              getLinkedAccountsEntities[index], appLocalizations);
        }),
        ...List.generate(mandateList.length, (index) {
          return _buildTableRowMandate(
              context, index, mandateList[index], appLocalizations);
        }),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, int index,
      GetLinkedAccountsEntity e, AppLocalizations appLocalizations) {
    return TableRow(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        ListTile(
          // leading: Icon(Icons.food_bank),
          title: Text(e.bankName),
          // subtitle: Text('Name of real estate'),
        ),
        Text(CustomizableDateTime.ddMmYyyyWithSlash(e.dateLinked)),
        ListTile(
          title: Text(e.type),
          subtitle: Text(e.subType),
        ),
        const Text(' '),
        TextButton(
            onPressed: () {
              context.read<LinkedAccountsCubit>().deleteLinkedAccounts(
                  DeleteCustodianBankStatusParams(id: e.id));
            },
            child: Text(appLocalizations.common_button_delete)),
      ],
    );
  }

  TableRow _buildTableRowMandate(BuildContext context, int index,
      GetMandateStatusEntity e, AppLocalizations appLocalizations) {
    return TableRow(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        ListTile(
          // leading: Icon(Icons.food_bank),
          title: Text(e.dataSource),
          // subtitle: Text('Name of real estate'),
        ),
        Text(CustomizableDateTime.ddMmYyyyWithSlash(DateTime.now())),
        ListTile(
          title: Text(e.dataSource),
          subtitle: Text(e.dataSource),
        ),
        const Text(' '),
        TextButton(
            onPressed: null,
            child: Text(appLocalizations.common_button_delete)),
      ],
    );
  }

  TableRow _buildTableHeader(BuildContext context, TextTheme textTheme) {
    final primaryColor = Theme.of(context).primaryColor;
    final appLocalizations = AppLocalizations.of(context);
    return TableRow(
      key: UniqueKey(),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      children: [
        ListTile(
            title: Text(appLocalizations.profile_linkedAccounts_name,
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        ListTile(
          title: Text(appLocalizations.profile_linkedAccounts_dateLinked,
              style: textTheme.bodyLarge!.apply(color: primaryColor)),
        ),
        ListTile(
            title: Text(appLocalizations.profile_linkedAccounts_type,
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        // ListTile(
        //   title: Text(appLocalizations.profile_linkedAccounts_serviceProvider,
        //       style: textTheme.bodyLarge!.apply(color: primaryColor)),
        // ),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }
}
