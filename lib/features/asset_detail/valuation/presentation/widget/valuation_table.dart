import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_all_valuation_params.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/get_all_valuation_entity.dart';
import 'package:wmd/features/valuation/presentation/widgets/valutaion_modal.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../manager/valuation_cubit.dart';

class ValuationWidget extends AppStatelessWidget {
  final String assetId;
  final String assetType;
  final bool isManuallyAdded;
  const ValuationWidget({
    Key? key,
    required this.assetId,
    required this.assetType,
    required this.isManuallyAdded,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Padding(
      padding: EdgeInsets.all(responsiveHelper.biggerGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.assets_label_valuation,
                style: textTheme.bodyLarge,
              ),
              if (AppConstants.publicMvp2Items && isManuallyAdded)
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (buildContext) {
                            return ValuationModalWidget(
                                title: '',
                                confirmBtn: appLocalizations.common_button_save,
                                cancelBtn:
                                    appLocalizations.common_button_cancel,
                                assetType: assetType,
                                assetId: assetId);
                          });

                      // context.pushNamed(AppRoutes.forgetPassword);
                    },
                    child: Text(
                      appLocalizations
                          .assets_valuationModal_buttons_buttons_addValuation,
                      style: textTheme.bodySmall!.toLinkStyle(context),
                    ))
            ],
          ),
          Text(
            appLocalizations.assets_label_keepNetWorth,
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
                    return Text(appLocalizations.common_emptyText_title);
                  }
                  return ValuationTableWidget(
                    getAllValuationEntities: state.getAllValuationEntities,
                    assetType: assetType,
                    assetId: assetId,
                    isManuallyAdded: isManuallyAdded,
                  );
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
  const ValuationTableWidget({
    super.key,
    required this.getAllValuationEntities,
    required this.assetId,
    required this.assetType,
    required this.isManuallyAdded,
  });
  final List<GetAllValuationEntity> getAllValuationEntities;
  final String assetId;
  final String assetType;
  final bool isManuallyAdded;

  @override
  AppState<ValuationTableWidget> createState() => _ValuationTableWidgetState();
}

class _ValuationTableWidgetState extends AppState<ValuationTableWidget> {
  bool isSummary = true;
  final limit = 5;
  static const columnWidths = {
    0: IntrinsicColumnWidth(),
    1: FlexColumnWidth(0.3),
    2: FlexColumnWidth(1.7),
    3: FlexColumnWidth(0.3),
    4: IntrinsicColumnWidth(),
    // 3: IntrinsicColumnWidth(),
    // 4: FlexColumnWidth(1),
  };
  @override
  Widget buildWidget(BuildContext context, texttheme, appLocalizations) {
    final length = widget.getAllValuationEntities.length;
    if (isSummary) {
      return Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: columnWidths,
            children: [
              buildTableHeader(context, appLocalizations),
              ...List.generate(length > limit ? limit : length, (index) {
                final e = widget.getAllValuationEntities[index];
                return buildTableRow(context,
                    date: CustomizableDateTime.ddMmYyyy(e.valuatedAt),
                    note: e.note ?? '',
                    value: e.amountInUsd.convertMoney(addDollar: true),
                    isSystemGenerated: e.isSystemGenerated,
                    index: index);
              }),
            ],
          ),
          if (length > limit)
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
                        appLocalizations.common_button_viewMore,
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
    return Column(children: [
      Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: columnWidths,
        children: [
          buildTableHeader(context, appLocalizations),
          ...List.generate(widget.getAllValuationEntities.length, (index) {
            final e = widget.getAllValuationEntities[index];

            debugPrint('getAllValuationEntities---');
            debugPrint(e.toString());

            return buildTableRow(context,
                date: CustomizableDateTime.ddMmYyyy(e.valuatedAt),
                note: e.note ?? '',
                value: e.amountInUsd.convertMoney(addDollar: true),
                isSystemGenerated: e.isSystemGenerated,
                index: index);
          }),
        ],
      ),
      if (length > limit)
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
                    appLocalizations.common_button_viewLess,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        )
    ]);
  }

  TableRow buildTableHeader(
      BuildContext context, AppLocalizations appLocalization,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8)}) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      children: [
        Padding(
          padding: padding,
          child: Text(
            appLocalization.assets_label_updatedDate,
            style: textTheme.bodySmall,
          ),
        ),
        const SizedBox.shrink(),
        Padding(
          padding: padding,
          child: Text(
            appLocalization.assets_label_notes,
            style: textTheme.bodySmall,
          ),
        ),
        const SizedBox.shrink(),
        Padding(
          padding: padding,
          child: Text(
            appLocalization.assets_label_value,
            style: textTheme.bodySmall,
          ),
        ),
        if (AppConstants.publicMvp2Items) const SizedBox.shrink(),
        if (AppConstants.publicMvp2Items && widget.isManuallyAdded)
          Padding(
            padding: padding,
            child: Text(
              "",
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
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
    required String date,
    required String note,
    required String value,
    required bool isSystemGenerated,
    required int index,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      key: UniqueKey(),
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
        const SizedBox.shrink(),
        Padding(
          padding: padding,
          child: PrivacyBlurWidget(
            child: Text(
              note,
              style: textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox.shrink(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: padding,
            child: PrivacyBlurWidget(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  value,
                  style: textTheme.labelMedium,
                ),
              ),
            ),
          ),
        ),
        if (AppConstants.publicMvp2Items) const SizedBox.shrink(),
        if (AppConstants.publicMvp2Items && widget.isManuallyAdded)
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              final List items = [
                [
                  AppLocalizations.of(context).common_button_edit,
                ],
                [
                  AppLocalizations.of(context).common_button_delete,
                ],
              ];
              return List.generate(
                  items.length,
                  (index) => PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(items[index][0]),
                          ],
                        ),
                        onTap: () async {
                          if (index == 0) {
                            debugPrint("working edit");
                            Future.delayed(
                                const Duration(seconds: 0),
                                () => showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      debugPrint("working edit");
                                      return ValuationModalWidget(
                                        title: '',
                                        confirmBtn: AppLocalizations.of(context)
                                            .common_button_save,
                                        cancelBtn: AppLocalizations.of(context)
                                            .common_button_cancel,
                                        assetType: widget.assetType,
                                        assetId: widget.assetId,
                                        isEdit: true,
                                      );
                                    }));
                            ;
                          } else {
                            // delete here
                            debugPrint("working delete");
                          }
                        },
                      ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.more_horiz,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
      ],
    );
  }
}
