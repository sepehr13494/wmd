import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/custom_expansion_tile.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_params.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/global_functions.dart';

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
          return Card(
            child: CustomExpansionTile(
              iconColor: AppColors.primary,
              initiallyExpanded: isExpanded,
              onExpansionChanged: (value) {
                isExpanded = value;
                if (value == false && widget.initiallyExpanded) {
                  context.goNamed(AppRoutes.main,
                      queryParams: {'expandCustodian': "false"});
                }
              },
              title: Text(
                appLocalizations.home_custodianBankList_title,
                style: textTheme.labelLarge,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsiveHelper.bigger16Gap),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FractionColumnWidth(0.35),
                      1: FractionColumnWidth(0.4),
                      3: FractionColumnWidth(0.4),
                    },
                    children: [
                      buildTableHeader(textTheme, appLocalizations),
                      ...widget.mandateList
                          .map((e) => buildMandateRow(context, e, textTheme)),
                      ...state.statusEntity
                          .map((e) => buildTableRow(context, e, textTheme))
                    ],
                  ),
                ),
              ],
            ),
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

  TableRow buildTableRow(
      BuildContext context, StatusEntity e, TextTheme textTheme,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 8.0, bottom: 8)}) {
    final appLocalizations = AppLocalizations.of(context);
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),
      children: [
        Padding(
          padding: padding,
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
                style: textTheme.bodyLarge),
          ),
        ),
        Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                final resPopup = await showCustodianBankStatus(
                  context: context,
                  bankId: e.bankId,
                  id: e.id,
                );

                // ignore: use_build_context_synchronously
                context
                    .read<CustodianStatusListCubit>()
                    .getCustodianStatusList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    appLocalizations.home_custodianBankList_button_view,
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
        )
      ],
    );
  }

  TableRow buildMandateRow(
      BuildContext context, GetMandateStatusEntity e, TextTheme textTheme,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 8.0, bottom: 8)}) {
    final appLocalizations = AppLocalizations.of(context);
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Theme.of(context).disabledColor),
        ),
      ),
      children: [
        Padding(
          padding: padding,
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
                style: textTheme.bodyLarge),
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
