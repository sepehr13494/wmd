import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';
import 'package:wmd/features/settings/linked_accounts/presentation/manager/linked_accounts_cubit.dart';

class LinkedTableTablet extends AppStatelessWidget {
  final List<GetLinkedAccountsEntity> getLinkedAccountsEntities;
  const LinkedTableTablet({required this.getLinkedAccountsEntities, super.key});

  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
    2: FlexColumnWidth(),
    3: IntrinsicColumnWidth(),
    4: IntrinsicColumnWidth(),
  };

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    if (getLinkedAccountsEntities.isEmpty) {
      return Text(appLocalizations.common_glossary_noDataFoundHeading);
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        _buildTableHeader(context, textTheme),
        ...List.generate(2, (index) {
          return _buildTableRow(context, index,
              getLinkedAccountsEntities[index], appLocalizations);
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

  TableRow _buildTableHeader(BuildContext context, TextTheme textTheme) {
    final primaryColor = Theme.of(context).primaryColor;
    return TableRow(
      key: UniqueKey(),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      children: [
        ListTile(
            title: Text('Name',
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        ListTile(
          title: Text('Date linked',
              style: textTheme.bodyLarge!.apply(color: primaryColor)),
        ),
        ListTile(
            title: Text('Type',
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        ListTile(
          title: Text('Service provider',
              style: textTheme.bodyLarge!.apply(color: primaryColor)),
        ),
        const SizedBox(),
      ],
    );
  }
}
