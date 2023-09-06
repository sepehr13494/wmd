import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_more_bottom_sheet.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_params.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

import '../../../mandate_status/domain/entities/get_mandate_status_entity.dart';

class BanksAuthorizationProcess extends StatefulWidget {
  final bool initiallyExpanded;
  final List<GetMandateStatusEntity> mandateList;
  const BanksAuthorizationProcess(
      {super.key, required this.initiallyExpanded, required this.mandateList});

  @override
  AppState<BanksAuthorizationProcess> createState() =>
      _BanksAuthorizationProcessState();
}

class _BanksAuthorizationProcessState
    extends AppState<BanksAuthorizationProcess> {
  bool isExpanded = false;
  int limit = 3;

  @override
  void initState() {
    isExpanded = widget.initiallyExpanded;
    super.initState();
  }

  @override
  void didUpdateWidget(BanksAuthorizationProcess oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      isExpanded = widget.initiallyExpanded;
    });
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return BlocConsumer<CustodianStatusListCubit, CustodianStatusListState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      builder: (context, state) {
        if (state is StatusListLoaded) {
          if (state.statusEntity.isEmpty && widget.mandateList.isEmpty) {
            return const SizedBox.shrink();
          }
          int length = 0;

          final custodainArr = [];

          // Iterate over the second array and add it to the new array as a map with the identifier 1
          for (var i = 0; i < widget.mandateList.length; i++) {
            custodainArr
                .add({"type": "mandate", "element": widget.mandateList[i]});
            length++;
          }

          // Iterate over the first array and add it to the new array as a map with the identifier 0
          for (var i = 0; i < state.statusEntity.length; i++) {
            if (state.statusEntity[i].status != CustodianStatus.SyncDone) {
              custodainArr.add(
                  {"type": "statusEntity", "element": state.statusEntity[i]});
              length++;
            }
          }

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveHelper.defaultSmallGap),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    appLocalizations.home_custodianBankList_title,
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FractionColumnWidth(0.35),
                  1: FractionColumnWidth(0.4),
                  3: FractionColumnWidth(0.4),
                },
                children: [
                  buildTableHeader(textTheme, appLocalizations),
                  ...List.generate(length > limit ? limit : length, (index) {
                    final e = custodainArr[index];

                    if (e["type"] == "mandate") {
                      return buildMandateRow(
                          context, e['element'], textTheme, index);
                    }

                    return buildTableRow(
                        context, e['element'], textTheme, index);
                  }),
                ],
              ),
              if (length > limit)
                InkWell(
                  onTap: () {
                    setState(() {
                      limit = length;
                    });
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            appLocalizations.common_button_viewMore,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ]),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  TableRow buildTableHeader(
      TextTheme textTheme, AppLocalizations appLocalizations,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 8.0, bottom: 8)}) {
    return TableRow(
      children: [
        Padding(
          padding: padding,
          child: Text(
            appLocalizations.home_custodianBankList_label_bankName,
            style: textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            appLocalizations.home_custodianBankList_label_status,
            style: textTheme.bodyMedium,
          ),
        ),
        const SizedBox.shrink()
      ],
    );
  }

  TableRow buildTableRow(BuildContext context, CustodianBankStatusEntity e,
      TextTheme textTheme, int index,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 8.0, bottom: 8)}) {
    final appLocalizations = AppLocalizations.of(context);
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Text(
            e.bankName,
            style: textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: padding,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(e.statusText(appLocalizations),
                style: textTheme.bodyMedium),
          ),
        ),
        Padding(
            padding: padding,
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    // Navigator.pop(context);

                    showModalBottomSheet(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        isScrollControlled: true,
                        context: context,
                        builder: (bottomSheetContext) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (context) =>
                                      sl<CustodianBankAuthCubit>()
                                  // value: context.read<CustodianBankAuthCubit>(),
                                  ),
                              BlocProvider.value(
                                value: context.read<CustodianStatusListCubit>(),
                              ),
                            ],
                            child: CustodianMoreBottomSheet(
                              bankId: e.bankId,
                              id: e.id,
                            ),
                          );

                          // return CustodianMoreBottomSheet(
                          //   bankId: e.bankId,
                          //   id: e.id,
                          // );
                        });
                  },
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).primaryColor,
                  )),
            ))
      ],
    );
  }

  TableRow buildMandateRow(BuildContext context, GetMandateStatusEntity e,
      TextTheme textTheme, int index,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 8.0, bottom: 8)}) {
    final appLocalizations = AppLocalizations.of(context);
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 != 0
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Text(
            e.dataSource,
            style: textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: padding,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
                appLocalizations.home_custodianBankList_statusText_mandateSync
                    .replaceFirst('{{mandateId}}', e.mandateId.toString()),
                style: textTheme.bodyMedium),
          ),
        ),
        Visibility(
          visible: false,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: padding,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    GlobalFunctions.showConfirmDialog(
                      context: context,
                      title: '',
                      body: appLocalizations
                          .linkAccount_deleteCustodianBankModal_description,
                      confirm: appLocalizations.common_button_yes,
                      cancel: appLocalizations.common_button_no,
                      onConfirm: () {
                        context
                            .read<MandateStatusCubit>()
                            .deleteMandate(DeleteMandateParams(e.mandateId));
                        setState(() {});
                        context.read<MandateStatusCubit>().getMandateStatus();
                        context
                            .read<CustodianStatusListCubit>()
                            .getCustodianStatusList();
                        GlobalFunctions.showSnackTile(context,
                            title: appLocalizations
                                .home_custodianBankList_toast_deleteMandate_title,
                            color: Colors.green);
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        appLocalizations
                            .home_custodianBankList_button_deleteSync,
                        style: textTheme.bodyLarge!
                            .apply(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
