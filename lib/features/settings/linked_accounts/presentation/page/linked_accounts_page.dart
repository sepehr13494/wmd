import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/injection_container.dart';

import '../manager/linked_accounts_cubit.dart';

class LinkedAccountsPage extends AppStatelessWidget {
  const LinkedAccountsPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    final isMobile = ResponsiveHelper(context: context).isMobile;
    return BlocProvider<LinkedAccountsCubit>(
      create: (context) => sl<LinkedAccountsCubit>()..getLinkedAccounts(),
      child: BlocConsumer<LinkedAccountsCubit, LinkedAccountsState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
        log("Mert $state");
      }), builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalizations.profile_tabs_linkedAccounts_name,
                      style: textTheme.headlineSmall,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Show all',
                                child: Row(
                                  children: [
                                    Text(
                                      'Show all',
                                      style: textTheme.bodyMedium!,
                                      // textTheme.bodyMedium!.toLinkStyle(context),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: ((value) async {}),
                            value: 'Show all',
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 15,
                              color: primaryColor,
                            ),
                            // style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                isMobile
                    ? const LinkedTableMobile()
                    : const LinkedTableTablet(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Link new account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LinkedTableTablet extends AppStatelessWidget {
  const LinkedTableTablet({super.key});

  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
    2: IntrinsicColumnWidth(),
    3: IntrinsicColumnWidth(),
    4: IntrinsicColumnWidth(),
  };

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        _buildTableHeader(context, textTheme),
        ...List.generate(2, (index) {
          return _buildTableRow(context, index);
        }),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, int index) {
    return TableRow(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        const ListTile(
          leading: Icon(Icons.food_bank),
          title: Text('Dubai House'),
          subtitle: Text('Name of real estate'),
        ),
        const Text('03/26/2019'),
        const ListTile(
          title: Text('Bank account'),
          subtitle: Text('Asset'),
        ),
        const Text('Plaid'),
        TextButton(onPressed: () {}, child: const Text('Delete')),
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

class LinkedTableMobile extends AppStatelessWidget {
  const LinkedTableMobile({super.key});

  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
  };

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        _buildTableHeader(context, textTheme),
        ...List.generate(2, (index) {
          return _buildTableRow(context, index);
        }),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, int index) {
    return TableRow(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        const ListTile(
          leading: Icon(Icons.food_bank),
          title: Text('Dubai House'),
          subtitle: Text('Name of real estate'),
        ),
        const ListTile(
          title: Text('Bank account'),
          subtitle: Text('Asset'),
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
