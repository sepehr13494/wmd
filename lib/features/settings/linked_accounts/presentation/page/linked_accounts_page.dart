import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class LinkedAccountsPage extends AppStatelessWidget {
  const LinkedAccountsPage({super.key});

  static const columnWidths = {
    // 0: IntrinsicColumnWidth(),
    0: FlexColumnWidth(0.3),
    1: FlexColumnWidth(0.3),
    2: FlexColumnWidth(0.3),
    // 3: FlexColumnWidth(0.3),
    3: IntrinsicColumnWidth(),
    4: IntrinsicColumnWidth(),
    // 3: IntrinsicColumnWidth(),
    // 4: FlexColumnWidth(1),
  };

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                  border: Border.all(color: Theme.of(context).dividerColor),
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
          const SizedBox(height: 16),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: columnWidths,
            children: [
              _buildTableHeader(context, textTheme),
              ...List.generate(5, (index) {
                return _buildTableRow(context, index);
              }),
            ],
          ),
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
