import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';

class LinkedTableMobile extends AppStatelessWidget {
  final List<GetLinkedAccountsEntity> getLinkedAccountsEntities;
  const LinkedTableMobile({required this.getLinkedAccountsEntities, super.key});

  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
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
        ...List.generate(getLinkedAccountsEntities.length, (index) {
          return _buildTableRow(
              context, index, getLinkedAccountsEntities[index]);
        }),
      ],
    );
  }

  TableRow _buildTableRow(
      BuildContext context, int index, GetLinkedAccountsEntity e) {
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
        ListTile(
          title: Text(e.type),
          subtitle: Text(e.subType),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_right_outlined,
              color: Theme.of(context).primaryColor,
            ))
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
            title: Text('Type',
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        const SizedBox(),
      ],
    );
  }
}


