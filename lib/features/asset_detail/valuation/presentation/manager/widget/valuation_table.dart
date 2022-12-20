import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_all_valuation_params.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/get_all_valuation_entity.dart';
import 'package:wmd/injection_container.dart';

import '../valuation_cubit.dart';

class ValuationWidget extends AppStatelessWidget {
  final String assetId;
  const ValuationWidget({Key? key, required this.assetId}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Padding(
      padding: EdgeInsets.all(responsiveHelper.biggerGap),
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
          BlocProvider(
            create: (context) => sl<ValuationCubit>()
              ..getAllValuation(GetAllValuationParams(assetId)),
            child: BlocConsumer<ValuationCubit, ValuationState>(
              listener: BlocHelper.defaultBlocListener(
                listener: (context, state) {},
              ),
              builder: (context, state) {
                if (state is GetAllValuationLoaded) {
                  if (state.getAllValuationEntities.isEmpty) {
                    return const Text('No history');
                  }
                  return ValuationTableWidget(
                      getAllValuationEntities: state.getAllValuationEntities);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ValuationTableWidget extends StatefulWidget {
  const ValuationTableWidget(
      {super.key, required this.getAllValuationEntities});
  final List<GetAllValuationEntity> getAllValuationEntities;

  @override
  AppState<ValuationTableWidget> createState() => _ValuationTableWidgetState();
}

class _ValuationTableWidgetState extends AppState<ValuationTableWidget> {
  bool isSummary = true;
  @override
  Widget buildWidget(BuildContext context, texttheme, applocalizations) {
    final length = widget.getAllValuationEntities.length;
    if (isSummary) {
      return Column(
        children: [
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
              ...List.generate(length > 3 ? 3 : length, (index) {
                final e = widget.getAllValuationEntities[index];
                return buildTableRow(context,
                    date: CustomizableDateTime.ddMmYyyy(e.createdAt),
                    note: e.note ?? '',
                    value: e.amountInUsd.convertMoney(addDollar: true),
                    index: index);
              }),
            ],
          ),
          if (length > 3)
            InkWell(
              onTap: () {
                setState(() {
                  isSummary = !isSummary;
                });
              },
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
      );
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(3),
        3: IntrinsicColumnWidth(),
        // 4: FlexColumnWidth(1),
      },
      children: [
        buildTableHeader(context),
        ...List.generate(widget.getAllValuationEntities.length, (index) {
          final e = widget.getAllValuationEntities[index];
          return buildTableRow(context,
              date: CustomizableDateTime.ddMmYyyy(e.createdAt),
              note: e.note ?? '',
              value: e.amountInUsd.convertMoney(addDollar: true),
              index: index);
        }),
      ],
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