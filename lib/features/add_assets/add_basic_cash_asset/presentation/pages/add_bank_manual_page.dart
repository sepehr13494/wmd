import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_form_builder_date_picker.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/account_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/pages/base_add_assest_state.dart';
import 'package:wmd/features/add_assets/core/presentation/pages/base_add_asset_stateful_widget.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_confirmation_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/bank_account/data/model/bank_account_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/presentation/manager/edit_bank_manual_cubit.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/dont_show_settings/presentation/manager/dont_show_settings_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../widgets/bank_name_type_ahead.dart';

class AddBankManualPage extends BaseAddAssetStatefulWidget {
  final BankAccountMoreEntity? moreEntity;

  const AddBankManualPage({Key? key, this.moreEntity, bool edit = false})
      : super(key: key, edit: edit);

  @override
  AppState<AddBankManualPage> createState() => _AddBankManualPageState();
}

class _AddBankManualPageState extends BaseAddAssetState<AddBankManualPage> {
  String date = "--/--/--";
  String? accountType;
  DateTime? endDateToParse;
  DateTime? startDateValue;
  bool isChecked = false;

  @override
  void initState() {
    if (widget.edit) {
      Future.delayed(const Duration(seconds: 1), () {
        accountType = widget.moreEntity!.toFormJson(context)["accountType"];
        startDateValue = widget.moreEntity!.toFormJson(context)["startDate"];
        changeDate();
      });
    }
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool edit = widget.edit;
    final isDepositTerm = accountType == "TermDeposit";
    final isSavingAccount = accountType == "SavingAccount";
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BankCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditBankManualCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DontShowSettingsCubit>()..getSettings(),
        ),
      ],
      child: Builder(builder: (context) {
        final bool isMobile = ResponsiveHelper(context: context).isMobile;
        return WillPopScope(
          onWillPop: () {
            return handleAssetBackButton(context);
          },
          child: Scaffold(
            appBar: const AddAssetHeader(title: "", showExitModal: true),
            bottomSheet:
                BlocListener<DontShowSettingsCubit, DontShowSettingsState>(
              listener: BlocHelper.defaultBlocListener(
                listener: (context, state) {
                  if (state is GetSettingsLoaded) {
                    isChecked = state.getSettingsEntities.isBankAccountChecked;
                  }
                },
              ),
              child: AddAssetFooter(
                buttonText: edit
                    ? appLocalizations.common_button_save
                    : appLocalizations.common_button_addAsset,
                onTap: (edit && !enableAddAssetButtonEdit)
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic> finalMap = {
                            ...formKey.currentState!.instantValue,
                          };
                          if (isDepositTerm && endDateToParse != null) {
                            finalMap["endDate"] = endDateToParse;
                          }
                          if (edit) {
                            context.read<EditBankManualCubit>().putBankManual(
                                map: finalMap, assetId: widget.moreEntity!.id);
                          } else {
                            bool add = true;
                            if (!isChecked) {
                              final conf = await showAssetConfirmationModal(
                                  context,
                                  assetType: AssetTypes.bankAccount);
                              if (conf != null &&
                                  conf.isConfirmed &&
                                  conf.isDontShowSelected) {
                                // ignore: use_build_context_synchronously
                                context
                                    .read<DontShowSettingsCubit>()
                                    .putSettings(const PutSettingsParams(
                                        isBankAccountChecked: true));
                              }
                              add = conf != null && conf.isConfirmed;
                            }
                            if (add) {
                              // ignore: use_build_context_synchronously
                              context.read<BankCubit>().postBankDetails(map: {
                                ...finalMap,
                                "ownershipPercentage": "100"
                              });
                            }
                          }
                        }
                      },
              ),
            ),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Builder(builder: (context) {
                final Widget deleteWidget = DeleteAssetBaseWidget(
                    name: AssetTypes.bankAccount,
                    realAssetName: widget.moreEntity != null
                        ? widget.moreEntity!.bankName
                        : "",
                    onTap: () {
                      context
                          .read<EditBankManualCubit>()
                          .deleteBankManual(assetId: widget.moreEntity!.id);
                    });
                return Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      width: edit ? 1000 : 500,
                      child: Builder(builder: (context) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<BankCubit, BankSaveState>(
                              listener: AssetBlocHelper.defaultBlocListener(
                                  listener: (context, state) {},
                                  asset: "Bank account",
                                  assetType: AssetTypes.bankAccount),
                            ),
                            BlocListener<EditBankManualCubit,
                                EditAssetBaseState>(
                              listener: EditAssetBlocHelper.defaultBlocListener(
                                  type: AssetTypes.bankAccount,
                                  assetId: edit ? widget.moreEntity!.id : ""),
                            ),
                          ],
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (!isMobile && edit)
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        deleteWidget,
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 32),
                                          width: 0.7,
                                          height: 200,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (isMobile && edit)
                                            ? deleteWidget
                                            : const SizedBox(),
                                        FormBuilder(
                                          key: formKey,
                                          initialValue: edit
                                              ? widget.moreEntity!
                                                  .toFormJson(context)
                                              : AddAssetConstants
                                                  .initialJsonForAddAsset(
                                                      context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              edit
                                                  ? const SizedBox()
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_heading_bankAccount,
                                                          style: textTheme
                                                              .headlineSmall,
                                                        ),
                                                        const SizedBox(
                                                            height: 24),
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_subHeading_bankAccount,
                                                          style: textTheme
                                                              .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                              Text(
                                                appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_title,
                                                style: textTheme.titleSmall,
                                              ),
                                              EachTextField(
                                                  hasInfo: false,
                                                  title: appLocalizations
                                                      .assetLiabilityForms_forms_bankAccount_inputFields_bankName_label,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      BankNameTypeAhead(
                                                        enabled: !edit,
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_bankName_placeholder,
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_bankName_errorMessage,
                                                        extraValidators: [
                                                          (val) {
                                                            return (val !=
                                                                        null &&
                                                                    val.length >
                                                                        50)
                                                                ? appLocalizations
                                                                    .common_errors_maxChar
                                                                    .replaceAll(
                                                                        "{{maxChar}}",
                                                                        "50")
                                                                : null;
                                                          }
                                                        ],
                                                        name: "bankName",
                                                        onChange: (e) {
                                                          if (e != null) {
                                                            checkFinalValid(e);
                                                          }
                                                        },
                                                      ),
                                                      if (AppConstants
                                                          .isRelease2)
                                                        TextButton(
                                                          onPressed: () {
                                                            context.goNamed(
                                                                AppRoutes
                                                                    .autoManualPage);
                                                          },
                                                          child: Text(
                                                            appLocalizations
                                                                .linkAccount_automaticLink_title,
                                                            style: textTheme
                                                                .titleSmall!
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          ),
                                                        )
                                                    ],
                                                  )),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_description_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_description_errorMessage,
                                                        extraValidators: [
                                                          (val) {
                                                            return (val !=
                                                                        null &&
                                                                    val.length >
                                                                        50)
                                                                ? appLocalizations
                                                                    .common_errors_maxChar
                                                                    .replaceAll(
                                                                        "{{maxChar}}",
                                                                        "50")
                                                                : null;
                                                          }
                                                        ],
                                                        onChanged:
                                                            checkFinalValid,
                                                        name: "description",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_description_placeholder),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_country_label,
                                                child: CountriesDropdown(
                                                  enabled: !edit,
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_accountType_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_accountType_label,
                                                child: AppTextFields
                                                    .dropDownTextField(
                                                  enabled:
                                                      !(edit && isDepositTerm),
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_bankAccount_inputFields_accountType_errorMessage,
                                                  onChanged: (val) async {
                                                    setState(() {
                                                      accountType = val;
                                                    });
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 200));
                                                    checkFinalValid(val);
                                                  },
                                                  name: "accountType",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_bankAccount_inputFields_accountType_placeholder,
                                                  items:
                                                      AccountType.accountList(
                                                              context)
                                                          .map((e) {
                                                    bool enabled = true;
                                                    if (edit) {
                                                      if (isDepositTerm) {
                                                        if (e.value ==
                                                                "SavingAccount" ||
                                                            e.value ==
                                                                "CurrentAccount") {
                                                          enabled = false;
                                                        }
                                                      } else {
                                                        if (e.value ==
                                                            "TermDeposit") {
                                                          enabled = false;
                                                        }
                                                      }
                                                    }
                                                    return DropdownMenuItem(
                                                      enabled: enabled,
                                                      value: e.value,
                                                      child: Text(
                                                        _accountTypeName(
                                                            e.value,
                                                            appLocalizations),
                                                        style: TextStyle(
                                                            color: !enabled
                                                                ? Theme.of(
                                                                        context)
                                                                    .disabledColor
                                                                : null),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .common_tooltip_currency,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_currency_label,
                                                child: CurrenciesDropdown(
                                                  enabled: AppConstants
                                                          .currencyConvertor &&
                                                      !edit,
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              if (!isDepositTerm)
                                                Column(
                                                  children: [
                                                    EachTextField(
                                                      hasInfo: false,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_balance_label,
                                                      child: AppTextFields.simpleTextField(
                                                          enabled: !edit,
                                                          errorMsg: appLocalizations
                                                              .assetLiabilityForms_forms_bankAccount_inputFields_balance_errorMessage,
                                                          name:
                                                              "currentBalance",
                                                          hint: appLocalizations
                                                              .assetLiabilityForms_forms_bankAccount_inputFields_balance_placeholder,
                                                          type: TextFieldType
                                                              .money,
                                                          onChanged:
                                                              checkFinalValid,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number),
                                                    ),
                                                    isSavingAccount
                                                        ? EachTextField(
                                                            title: appLocalizations
                                                                .assetLiabilityForms_forms_bankAccount_inputFields_rate_label,
                                                            child: AppTextFields
                                                                .simpleTextField(
                                                                    enabled:
                                                                        !edit,
                                                                    name:
                                                                        "interestRate",
                                                                    suffixIcon:
                                                                        AppTextFields
                                                                            .rateSuffixIcon(),
                                                                    type: TextFieldType
                                                                        .rate,
                                                                    required:
                                                                        false,
                                                                    hint: appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_rate_placeholder,
                                                                    onChanged:
                                                                        checkFinalValid,
                                                                    extraValidators: [
                                                                      (val) {
                                                                        return ((int.tryParse(val ?? "0") ?? 0) <
                                                                                100)
                                                                            ? (int.tryParse(val ?? "0") ?? 0) < 0
                                                                                ? "Rate cannot be negative"
                                                                                : null
                                                                            : "Rate can't be greater then 100";
                                                                      }
                                                                    ],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number),
                                                          )
                                                        : const SizedBox()
                                                  ]
                                                      .map((e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        0),
                                                            child: e,
                                                          ))
                                                      .toList(),
                                                ),
                                              if (isDepositTerm)
                                                Column(
                                                  children: [
                                                    // EachTextField(
                                                    //   tooltipText: appLocalizations
                                                    //       .assetLiabilityForms_forms_bankAccount_inputFields_ownership_tooltip,
                                                    //   title: appLocalizations
                                                    //       .assetLiabilityForms_forms_bankAccount_inputFields_ownership_label,
                                                    //   child: AppTextFields.simpleTextField(
                                                    //       extraValidators: [
                                                    //         (val) {
                                                    //           return ((int.tryParse(val ??
                                                    //                           "0") ??
                                                    //                       0) <=
                                                    //                   100)
                                                    //               ? null
                                                    //               : "Ownership can't be greater then 100";
                                                    //         }
                                                    //       ],
                                                    //       onChanged:
                                                    //           checkFinalValid,
                                                    //       name:
                                                    //           "ownershipPercentage",
                                                    //       errorMsg: appLocalizations
                                                    //           .assetLiabilityForms_forms_bankAccount_inputFields_ownership_errorMessage_error,
                                                    //       hint: appLocalizations
                                                    //           .assetLiabilityForms_forms_bankAccount_inputFields_ownership_placeholder,
                                                    //       type: TextFieldType
                                                    //           .rate,
                                                    //       suffixIcon: AppTextFields
                                                    //           .rateSuffixIcon(),
                                                    //       keyboardType:
                                                    //           TextInputType
                                                    //               .number),
                                                    // ),
                                                    EachTextField(
                                                      tooltipText: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_principal_tooltip,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_principal_label,
                                                      child: AppTextFields
                                                          .simpleTextField(
                                                        enabled: !edit,
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_principal_errorMessage,
                                                        type:
                                                            TextFieldType.money,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged:
                                                            checkFinalValid,
                                                        name: "currentBalance",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_principal_placeholder,
                                                      ),
                                                    ),
                                                    EachTextField(
                                                      tooltipText: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_rate_tooltip,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_rate_label,
                                                      child: AppTextFields
                                                          .simpleTextField(
                                                        enabled: !edit,
                                                        extraValidators: [
                                                          (val) {
                                                            return ((int.tryParse(val ??
                                                                            "0") ??
                                                                        0) <=
                                                                    100)
                                                                ? (int.tryParse(val ??
                                                                                "0") ??
                                                                            0) <
                                                                        0
                                                                    ? appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_rate_errorMessage_minimum
                                                                    : null
                                                                : appLocalizations
                                                                    .assetLiabilityForms_forms_bankAccount_inputFields_rate_errorMessage_maximum;
                                                          }
                                                        ],
                                                        name: "interestRate",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_rate_placeholder,
                                                        type:
                                                            TextFieldType.rate,
                                                        keyboardType:
                                                            const TextInputType
                                                                    .numberWithOptions(
                                                                decimal: true),
                                                        suffixIcon: AppTextFields
                                                            .rateSuffixIcon(),
                                                        required: false,
                                                      ),
                                                    ),
                                                    EachTextField(
                                                      tooltipText: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_startDate_tooltip,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_startDate_label,
                                                      child:
                                                          AppFormBuilderDateTimePicker(
                                                        enabled: !edit,
                                                        name: "startDate",
                                                        lastDate:
                                                            DateTime.now(),
                                                        inputType:
                                                            InputType.date,
                                                        format: DateFormat(
                                                            "dd/MM/yyyy"),
                                                        onChanged:
                                                            (selectedDate) {
                                                          checkFinalValid(
                                                              selectedDate);
                                                          setState(() {
                                                            startDateValue =
                                                                selectedDate;
                                                          });
                                                          debugPrint(
                                                              selectedDate
                                                                  .toString());

                                                          changeDate();
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon:
                                                                    Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                hintText:
                                                                    appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_startDate_placeholder),
                                                      ),
                                                    ),
                                                    if (startDateValue != null)
                                                      EachTextField(
                                                          tooltipText:
                                                              appLocalizations
                                                                  .assetLiabilityForms_forms_bankAccount_inputFields_tenure_tooltip,
                                                          title: appLocalizations
                                                              .assetLiabilityForms_forms_bankAccount_inputFields_tenure_label,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      EachTextField(
                                                                    hasInfo:
                                                                        false,
                                                                    title: appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_tenureYears_label,
                                                                    child: AppTextFields.simpleTextField(
                                                                        enabled: !edit,
                                                                        required: false,
                                                                        customInputFormatters: <TextInputFormatter>[
                                                                          FilteringTextInputFormatter.allow(
                                                                              RegExp(r'^[1-9]$|^[1-9][0-9]{0,2}$')),
                                                                        ],
                                                                        extraValidators: [
                                                                          (val) {
                                                                            return ((int.tryParse(val ?? "0") ?? 0) <= 999)
                                                                                ? (int.tryParse(val ?? "0") ?? 0) < 0
                                                                                    ? appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureYears_errorMessage_minimum
                                                                                    : null
                                                                                : appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureYears_errorMessage_maximum;
                                                                          }
                                                                        ],
                                                                        onChanged: (val) {
                                                                          checkFinalValid(
                                                                              val);
                                                                          changeDate();
                                                                        },
                                                                        name: "years",
                                                                        hint: appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureYears_placeholder,
                                                                        keyboardType: TextInputType.number),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 12),
                                                                Expanded(
                                                                  child:
                                                                      EachTextField(
                                                                    hasInfo:
                                                                        false,
                                                                    title: appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_tenureMonths_label,
                                                                    child: AppTextFields.simpleTextField(
                                                                        enabled: !edit,
                                                                        name: "months",
                                                                        customInputFormatters: <TextInputFormatter>[
                                                                          FilteringTextInputFormatter.allow(
                                                                              RegExp(r'^[1-9]$|^1[0-2]$')),
                                                                        ],
                                                                        extraValidators: [
                                                                          (val) {
                                                                            return ((int.tryParse(val ?? "0") ?? 0) < 13)
                                                                                ? null
                                                                                : appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureMonths_errorMessage_maximum;
                                                                          }
                                                                        ],
                                                                        onChanged: (val) {
                                                                          checkFinalValid(
                                                                              val);
                                                                          changeDate();
                                                                        },
                                                                        hint: appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureMonths_placeholder,
                                                                        required: false,
                                                                        keyboardType: TextInputType.number),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 12),
                                                                Expanded(
                                                                  child:
                                                                      EachTextField(
                                                                    hasInfo:
                                                                        false,
                                                                    title: appLocalizations
                                                                        .assetLiabilityForms_forms_bankAccount_inputFields_tenureDays_label,
                                                                    child: AppTextFields.simpleTextField(
                                                                        enabled: !edit,
                                                                        required: false,
                                                                        customInputFormatters: <TextInputFormatter>[
                                                                          FilteringTextInputFormatter.allow(
                                                                              RegExp(r'^[1-9]$|^[1-2][0-9]$|^3[0-1]$')),
                                                                        ],
                                                                        extraValidators: [
                                                                          (val) {
                                                                            return ((int.tryParse(val ?? "0") ?? 0) < 32)
                                                                                ? null
                                                                                : appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureDays_errorMessage_maximum;
                                                                          }
                                                                        ],
                                                                        onChanged: (val) {
                                                                          checkFinalValid(
                                                                              val);
                                                                          changeDate();
                                                                        },
                                                                        name: "days",
                                                                        hint: appLocalizations.assetLiabilityForms_forms_bankAccount_inputFields_tenureDays_placeholder,
                                                                        keyboardType: TextInputType.number),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? AppColors
                                                                  .anotherCardColorForDarkTheme
                                                              : AppColors
                                                                  .anotherCardColorForLightTheme,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(appLocalizations
                                                                .assetLiabilityForms_labels_endTerm),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(date)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                      .map((e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        0),
                                                            child: e,
                                                          ))
                                                      .toList(),
                                                ),
                                            ]
                                                .map((e) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      child: e,
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }

  void changeDate() {
    final map = formKey.currentState!.instantValue;
    var startDate = map["startDate"];
    if (startDate != null &&
        (map["years"] != null ||
            map["months"] != null ||
            map["days"] != null)) {
      final int year = int.tryParse(map["years"] ?? "0") ?? 0;
      final int month = int.tryParse(map["months"] ?? "0") ?? 0;
      final int day = int.tryParse(map["days"] ?? "0") ?? 0;

      setState(() {
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day + day);
        startDate =
            DateTime(startDate.year, startDate.month + month, startDate.day);
        startDate =
            DateTime(startDate.year + year, startDate.month, startDate.day);
        date = "${startDate.day}/${startDate.month}/${startDate.year}";
        endDateToParse = startDate;
      });
    }
  }

  String _accountTypeName(String value, AppLocalizations appLocalizations) {
    switch (value) {
      case "SavingAccount":
        return appLocalizations
            .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_savingAccount;
      case "CurrentAccount":
        return appLocalizations
            .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_currentAccount;
      case "TermDeposit":
        return appLocalizations
            .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_termDeposit;
      default:
        return "";
    }
  }
}
