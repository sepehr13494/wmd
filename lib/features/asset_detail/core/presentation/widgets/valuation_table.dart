import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValuationWidget extends AppStatelessWidget {
  const ValuationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Valuation',
            style: textTheme.bodyLarge,
          ),
          Text(
            'To keep your networth updated, add your recent valuation.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(3),
              3: IntrinsicColumnWidth(),
              // 4: FlexColumnWidth(1),
            },
            children: [
              buildTableHeader(context),
              ...List.generate(
                  3,
                  (index) => buildTableRow(context,
                      date: '30.03.2022',
                      note:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed metus sed nibh',
                      value: '\$10000',
                      index: index)),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Load all",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TableRow buildTableHeader(BuildContext context,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4)}) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      children: [
        Padding(
          padding: padding,
          child: Text(
            'Date',
            style: textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            'Note',
            style: textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            'Value',
            style: textTheme.bodySmall,
          ),
        ),
        // const SizedBox.shrink(),
      ],
    );
  }

  TableRow buildTableRow(
    BuildContext context, {
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
    required String date,
    required String note,
    required String value,
    required int index,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        Padding(
          padding: padding,
          child: Text(
            date,
            style: textTheme.labelMedium!,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            note,
            style: textTheme.labelMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(value, style: textTheme.labelMedium),
        ),
        // const SizedBox.shrink(),
      ],
    );
  }
}
