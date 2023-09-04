import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/linked_accounts_icons_icons.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/entities/get_mandate_status_entity.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';

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
    3: FlexColumnWidth(),
    4: FlexColumnWidth(),
    // 4: IntrinsicColumnWidth(),
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
              context,
              getLinkedAccountsEntities.length + index,
              mandateList[index],
              appLocalizations);
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
        const SizedBox(width: 16),
        const CircularIcon(iconData: LinkedAccountsIcons.temple_1),
        ListTile(
          // leading: Icon(Icons.food_bank),
          title: Text(e.bankName),
          // subtitle: Text('Name of real estate'),
        ),
        Text(e.accountNumber),
        // ListTile(
        //   title: Text(e.type),
        //   subtitle: Text(e.subType),
        // ),
        Text(e.syncDate == null
            ? ''
            : CustomizableDateTime.ddMmYyyyWithSlash(e.syncDate!)),
        // TextButton(
        //     onPressed: () {
        //       context.read<LinkedAccountsCubit>().deleteLinkedAccounts(
        //           DeleteCustodianBankStatusParams(id: e.id));
        //     },
        //     child: Text(appLocalizations.common_button_delete)),
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
        const SizedBox(width: 16),
        const CircularIcon(iconData: LinkedAccountsIcons.group),
        ListTile(
          // leading: Icon(Icons.food_bank),
          title: Text(e.dataSource),
          // subtitle: Text('Name of real estate'),
        ),
        Text(e.mandateId.toString()),
        // ListTile(
        //   title: Text(e.dataSource),
        //   subtitle: Text(e.dataSource),
        // ),
        Text(e.syncDate == null
            ? ''
            : CustomizableDateTime.ddMmYyyyWithSlash(e.syncDate!)),
        // TextButton(
        //     onPressed: () {
        //       GlobalFunctions.showConfirmDialog(
        //         context: context,
        //         title: '',
        //         body: appLocalizations
        //             .linkAccount_deleteCustodianBankModal_description,
        //         confirm: appLocalizations.common_button_yes,
        //         cancel: appLocalizations.common_button_no,
        //         onConfirm: () {
        //           context
        //               .read<MandateStatusCubit>()
        //               .deleteMandate(DeleteMandateParams(e.mandateId));
        //           context.read<MandateStatusCubit>().getMandateStatus();
        //           GlobalFunctions.showSnackTile(context,
        //               title: appLocalizations
        //                   .home_custodianBankList_toast_deleteMandate_title,
        //               color: Colors.green);
        //         },
        //       );
        //     },
        //     child: Text(appLocalizations.common_button_delete)),
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
        const SizedBox(width: 16),
        const SizedBox(),
        ListTile(
            title: Text(appLocalizations.profile_linkedAccounts_name,
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        ListTile(
          title: Text(appLocalizations.profile_linkedAccounts_account,
              style: textTheme.bodyLarge!.apply(color: primaryColor)),
        ),
        ListTile(
            title: Text(appLocalizations.profile_linkedAccounts_dateLinked,
                style: textTheme.bodyLarge!.apply(color: primaryColor))),
        // ListTile(
        //   title: Text(appLocalizations.profile_linkedAccounts_serviceProvider,
        //       style: textTheme.bodyLarge!.apply(color: primaryColor)),
        // ),
        // const SizedBox(),
      ],
    );
  }
}

class CircularIcon extends StatelessWidget {
  final IconData iconData;
  const CircularIcon({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white12,
      child: Icon(
        iconData,
        color: Colors.white54,
      ),
    );
  }
}
