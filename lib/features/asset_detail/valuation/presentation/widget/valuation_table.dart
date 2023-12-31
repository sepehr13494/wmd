import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_summary_cubit.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_all_valuation_params.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/get_all_valuation_entity.dart';
import 'package:wmd/features/valuation/presentation/widgets/valuation_delete_modal.dart';
import 'package:wmd/features/valuation/presentation/widgets/valutaion_modal.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../manager/valuation_cubit.dart';

class ValuationWidget extends AppStatelessWidget {
  final String assetId;
  final String assetType;
  final bool isManuallyAdded;
  final double totalQuantity;
  final Function updateHoldings;
  const ValuationWidget({
    Key? key,
    required this.assetId,
    required this.assetType,
    required this.isManuallyAdded,
    required this.totalQuantity,
    required this.updateHoldings,
  }) : super(key: key);

  Widget renderTable(BuildContext context, TextTheme textTheme,
      appLocalizations, List<GetAllValuationEntity> getAllValuationEntities,
      {bool isValuation = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isValuation
                  ? appLocalizations.assets_activityList_valuations_heading
                  : appLocalizations.assets_activityList_transactions_heading,
              style: textTheme.bodyLarge,
            ),
            Row(
              children: [
                if ((isManuallyAdded &&
                        !isValuation &&
                        (totalQuantity > 0.0 ||
                            [
                              AssetTypes.listedAssetEquity,
                              AssetTypes.listedAsset,
                              AssetTypes.listedAssetFixedIncome,
                              AssetTypes.listedAssetOther,
                              AssetTypes.listedAssetOtherAsset
                            ].contains(assetType))) ||
                    assetType == AssetTypes.loanLiability)
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (buildContext) {
                              return BlocProvider.value(
                                  value: BlocProvider.of<AssetSummaryCubit>(
                                      context),
                                  child: ValuationModalWidget(
                                      title: '',
                                      confirmBtn:
                                          appLocalizations.common_button_save,
                                      cancelBtn:
                                          appLocalizations.common_button_cancel,
                                      assetType: assetType,
                                      assetId: assetId));
                            }).then((value) {
                          context
                              .read<ValuationCubit>()
                              .getAllTransactionValuation(
                                  GetAllValuationParams(assetId, assetType));
                          updateHoldings();
                        });

                        // context.pushNamed(AppRoutes.forgetPassword);
                      },
                      child: Text(
                        assetType == AssetTypes.bankAccount
                            ? appLocalizations
                                .assets_valuationModal_updateTheBalance
                            : appLocalizations.assets_valuationModal_heading
                                .replaceAll("{{addOrEdit}}",
                                    appLocalizations.common_button_add),
                        style: textTheme.bodySmall!.toLinkStyle(context),
                      )),
                if (isValuation)
                  if ((isManuallyAdded &&
                      (totalQuantity > 0.0 &&
                          [
                            AssetTypes.privateDebt,
                            AssetTypes.privateEquity,
                            AssetTypes.realEstate,
                            AssetTypes.otherAsset,
                            AssetTypes.otherAssets,
                          ].contains(assetType))))
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (buildContext) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<AssetSummaryCubit>(
                                        context),
                                    child: ValuationModalWidget(
                                        title: '',
                                        confirmBtn:
                                            appLocalizations.common_button_save,
                                        cancelBtn: appLocalizations
                                            .common_button_cancel,
                                        assetType: assetType,
                                        assetId: assetId,
                                        isValuation: true));
                              }).then((value) {
                            context
                                .read<ValuationCubit>()
                                .getAllTransactionValuation(
                                    GetAllValuationParams(assetId, assetType));
                            updateHoldings();
                          });

                          // context.pushNamed(AppRoutes.forgetPassword);
                        },
                        child: Text(
                          appLocalizations
                              .assets_valuationModal_headingValuation
                              .replaceAll("{{addOrEdit}}",
                                  appLocalizations.common_button_add),
                          style: textTheme.bodySmall!.toLinkStyle(context),
                        ))
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isValuation
              ? appLocalizations.assets_activityList_valuations_note
              : appLocalizations.assets_activityList_transactions_note,
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ValuationTableWidget(
          getAllValuationEntities: getAllValuationEntities ?? [],
          assetType: assetType,
          assetId: assetId,
          isManuallyAdded: isManuallyAdded,
          totalQuantity: totalQuantity,
          updateHoldings: updateHoldings,
          isValuation: isValuation,
        )
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    return Padding(
        padding: EdgeInsets.all(responsiveHelper.biggerGap),
        child: BlocConsumer<ValuationCubit, ValuationState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {},
            ),
            builder: (context, state) {
              if (state is LoadingState) {
                return const LoadingWidget();
              }
              return Column(
                children: [
                  if (([
                    AssetTypes.privateDebt,
                    AssetTypes.privateEquity,
                    AssetTypes.realEstate,
                    AssetTypes.otherAsset,
                    AssetTypes.otherAssets,
                  ].contains(assetType)))
                    renderTable(
                        context,
                        textTheme,
                        appLocalizations,
                        state is GetAllValuationLoaded
                            ? state.getAllValuationEntities
                            : [],
                        isValuation: true),
                  const SizedBox(height: 16),
                  renderTable(
                      context,
                      textTheme,
                      appLocalizations,
                      state is GetAllValuationLoaded
                          ? state.getAllTransactionEntities
                          : [],
                      isValuation: false),
                ],
              );
              // }
              // return const LoadingWidget();
            }));
  }
}

class ValuationTableWidget extends StatefulWidget {
  const ValuationTableWidget({
    super.key,
    required this.getAllValuationEntities,
    required this.assetId,
    required this.assetType,
    required this.isManuallyAdded,
    required this.totalQuantity,
    required this.updateHoldings,
    required this.isValuation,
  });
  final List<GetAllValuationEntity> getAllValuationEntities;
  final String assetId;
  final String assetType;
  final bool isManuallyAdded;
  final double totalQuantity;
  final Function updateHoldings;
  final bool isValuation;

  @override
  AppState<ValuationTableWidget> createState() => _ValuationTableWidgetState();
}

class _ValuationTableWidgetState extends AppState<ValuationTableWidget> {
  bool isSummary = true;
  bool isFirstTransRemoved = false;
  final limit = 5;
  static const columnWidths = {
    // 0: IntrinsicColumnWidth(),
    0: IntrinsicColumnWidth(),
    1: FlexColumnWidth(1.8),
    2: IntrinsicColumnWidth(),
    3: FlexColumnWidth(0.3),
    4: FlexColumnWidth(0.2),
    // 5: IntrinsicColumnWidth(),
    // 3: IntrinsicColumnWidth(),
    // 4: FlexColumnWidth(1),
  };

  @override
  void didUpdateWidget(ValuationTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isManuallyAdded &&
        (!isFirstTransRemoved ||
            (oldWidget.getAllValuationEntities !=
                widget.getAllValuationEntities))) {
      // Find the index of the last transaction
      int lastIndex = widget.getAllValuationEntities
          .lastIndexWhere((transaction) => transaction.type == 'transaction');
      if (lastIndex >= 0) {
        widget.getAllValuationEntities.removeAt(lastIndex);
      }

      if (widget.isValuation) {
        widget.getAllValuationEntities
            .removeWhere((transaction) => transaction.recordSource == 'WMD');
      }

      setState(() {
        isFirstTransRemoved = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (widget.isManuallyAdded && !isFirstTransRemoved) {
      // Find the index of the last transaction
      int lastIndex = widget.getAllValuationEntities
          .lastIndexWhere((transaction) => transaction.type == 'transaction');
      if (lastIndex >= 0) {
        widget.getAllValuationEntities.removeAt(lastIndex);
      }
      if (widget.isValuation) {
        widget.getAllValuationEntities
            .removeWhere((transaction) => transaction.recordSource == 'WMD');
      }

      setState(() {
        isFirstTransRemoved = true;
      });
    }
  }

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
              if (widget.getAllValuationEntities.isNotEmpty)
                ...List.generate(length > limit ? limit : length, (index) {
                  final e = widget.getAllValuationEntities[index];
                  return buildTableRow(
                    context,
                    date: CustomizableDateTime.ddMmYyyy(e.valuatedAt),
                    note: e.note ?? '',
                    value: e.amountInUsd.convertMoney(addDollar: true),
                    localValue: e.type == "transaction"
                        ? e.amount.convertMoney(addDollar: false)
                        : e.localCurrencyValue!.convertMoney(addDollar: false),
                    isSystemGenerated: e.isSystemGenerated,
                    index: index,
                    id: e.id,
                    isLast: e.isLast,
                    type: e.type,
                  );
                }),
            ],
          ),
          if (widget.getAllValuationEntities.isEmpty)
            buildEmptyTableRow(context, appLocalizations),
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
          if (widget.getAllValuationEntities.isNotEmpty)
            ...List.generate(widget.getAllValuationEntities.length, (index) {
              final e = widget.getAllValuationEntities[index];

              debugPrint('getAllValuationEntities---');
              debugPrint(e.toString());

              return buildTableRow(
                context,
                date: CustomizableDateTime.ddMmYyyy(e.valuatedAt),
                note: e.note ?? '',
                value: e.amountInUsd.convertMoney(addDollar: true),
                localValue: e.type == "transaction"
                    ? e.amount.convertMoney(addDollar: false)
                    : e.localCurrencyValue!.convertMoney(addDollar: false),
                isSystemGenerated: e.isSystemGenerated,
                index: index,
                id: e.id,
                isLast: e.isLast,
              );
            }),
        ],
      ),
      if (widget.getAllValuationEntities.isEmpty)
        buildEmptyTableRow(context, appLocalizations),
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
        Padding(
          padding: padding,
          child: Text(
            appLocalization.assets_label_notes,
            style: textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            appLocalization.assets_label_value,
            style: textTheme.bodySmall,
          ),
        ),
        (AppConstants.publicMvp2Items &&
                widget.isManuallyAdded &&
                widget.totalQuantity > 0)
            ? const SizedBox.shrink()
            : const SizedBox.shrink(),
        const SizedBox.shrink(),
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
    required String id,
    required bool isLast,
    String? type,
    required String localValue,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final AssetSummaryState assetSummeryState =
        context.watch<AssetSummaryCubit>().state;

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
        // const SizedBox.shrink(),
        Padding(
          padding: padding,
          child: PrivacyBlurWidget(
            child: Text(
              note,
              style: textTheme.labelMedium,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: padding,
            child: PrivacyBlurWidget(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  (assetSummeryState is AssetLoaded)
                      ? assetSummeryState.assetSummaryEntity.currencyCode ==
                              "USD"
                          ? value
                          : "${assetSummeryState.assetSummaryEntity.currencyCode} $localValue"
                      : value,
                  style: textTheme.labelMedium,
                ),
              ),
            ),
          ),
        ),
        (AppConstants.publicMvp2Items &&
                widget.isManuallyAdded &&
                isLast &&
                // (type == "valuation" ? isLast : true) &&
                widget.totalQuantity > 0 &&
                widget.assetType != AssetTypes.bankAccount)
            ? renderPopupMenu(context, id, type! == "valuation")
            : const SizedBox(width: 0),
        const SizedBox.shrink(),
      ],
    );
  }

  Widget renderPopupMenu(
    BuildContext context,
    String id,
    bool isValuation,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return PopupMenuButton(
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
                      final res = await Future.delayed(
                          const Duration(seconds: 0),
                          () => showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (buildContext) {
                                    return BlocProvider.value(
                                        value:
                                            BlocProvider.of<AssetSummaryCubit>(
                                                context),
                                        child: ValuationModalWidget(
                                            title: '',
                                            confirmBtn:
                                                AppLocalizations.of(context)
                                                    .common_button_save,
                                            cancelBtn:
                                                AppLocalizations.of(context)
                                                    .common_button_cancel,
                                            assetType: widget.assetType,
                                            assetId: widget.assetId,
                                            isEdit: true,
                                            valuationId: id,
                                            isValuation: isValuation));
                                  }).then((isConfirm) async {
                                try {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    try {
                                      widget.updateHoldings();
                                    } catch (e) {
                                      debugPrint(
                                          "on close action failed inside---");
                                      debugPrint(e.toString());
                                    }
                                  });
                                } catch (e) {
                                  debugPrint("on close action failed---");
                                  debugPrint(e.toString());
                                }

                                return isConfirm;
                              }));
                    } else {
                      // delete here

                      Future.delayed(
                          const Duration(seconds: 0),
                          () => showDialog(
                                context: context,
                                builder: (context) {
                                  return ValuationDeleteModal(
                                      title: isValuation
                                          ? AppLocalizations.of(context)
                                              .assets_valuationModal_deleteValuationHeading
                                          : AppLocalizations.of(context)
                                              .assets_valuationModal_deleteTransactionHeading,
                                      body: AppLocalizations.of(context)
                                          .assets_valuationModal_deleteTransactionDescription,
                                      confirmBtn: AppLocalizations.of(context)
                                          .common_button_delete,
                                      cancelBtn: AppLocalizations.of(context)
                                          .common_button_cancel,
                                      valuationId: id,
                                      assetId: widget.assetId,
                                      isValuation: isValuation);
                                },
                              ).then((isConfirm) {
                                context
                                    .read<ValuationCubit>()
                                    .getAllTransactionValuation(
                                        GetAllValuationParams(
                                            widget.assetId, widget.assetType));
                                if (isConfirm != null && isConfirm == true) {
                                  // handleFormSubmit(formStateKey, renderSubmitData, context, true);
                                }
                                return isConfirm;
                              }));
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
    );
  }

  Widget buildEmptyTableRow(
    BuildContext context,
    AppLocalizations appLocalizations, {
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Text(
          appLocalizations.common_emptyText_emptyState,
          style:
              textTheme.bodySmall!.apply(color: Theme.of(context).primaryColor),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
