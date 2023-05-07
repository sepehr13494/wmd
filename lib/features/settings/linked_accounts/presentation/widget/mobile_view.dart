import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/see_more_popup.dart';
import 'package:wmd/features/asset_see_more/core/presentation/widget/title_subtitle.dart';
import 'package:wmd/features/settings/linked_accounts/domain/entities/get_linked_accounts_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/settings/linked_accounts/presentation/manager/linked_accounts_cubit.dart';

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
            onPressed: () {
              showDetailModal(
                  context: context,
                  e: e,
                  onDelete: () {
                    context.read<LinkedAccountsCubit>().deleteLinkedAccounts(
                        DeleteCustodianBankStatusParams(id: e.id));
                  });
            },
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

Future<bool?> showDetailModal(
    {required BuildContext context,
    required GetLinkedAccountsEntity e,
    required Function() onDelete}) async {
  final appLocalizations = AppLocalizations.of(context);
  final textTheme = Theme.of(context).textTheme;
  final primaryColor = Theme.of(context).primaryColor;
  final isMobile = ResponsiveHelper(context: context).isMobile;
  return await showDialog<bool?>(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Account details',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 8),
                      TitleSubtitle(title: 'Name', subTitle: e.bankName),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleSubtitle(
                              title: 'Date Linked',
                              subTitle: CustomizableDateTime.ddMmYyyyWithSlash(
                                  e.dateLinked)),
                          TitleSubtitle(title: 'Type', subTitle: e.type),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const TitleSubtitle(
                          title: 'Service Provider', subTitle: '.'),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  onDelete();
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(double.infinity, 50)),
                                child: Text(
                                    appLocalizations.common_button_delete)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(double.infinity, 50)),
                                child: Text(
                                    appLocalizations.common_glossary_close)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // actionsOverflowButtonSpacing: 0,
        ),
      );
    },
  );
}
