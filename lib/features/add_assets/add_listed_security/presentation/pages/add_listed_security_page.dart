import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_form_builder_date_picker.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/no_data_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/manager/listed_security_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_confirmation_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/listed_asset/data/models/listed_asset_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/presentation/manager/edit_listed_asset_cubit.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/dont_show_settings/presentation/manager/dont_show_settings_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../core/presentation/pages/base_add_assest_state.dart';
import '../../../core/presentation/pages/base_add_asset_stateful_widget.dart';
import '../widgets/listed_asset_type_ahead.dart';

class AddListedSecurityPage extends BaseAddAssetStatefulWidget {
  final ListedAssetMoreEntity? moreEntity;

  const AddListedSecurityPage({Key? key, bool edit = false, this.moreEntity})
      : super(key: key, edit: edit);

  @override
  AppState<AddListedSecurityPage> createState() => _AddListedSecurityState();
}

class _AddListedSecurityState extends BaseAddAssetState<AddListedSecurityPage> {
  String currentDayValue = "--";
  String? noOfUnits = "";
  String? valuePerUnit = "";
  ListedSecurityName? securityName;
  bool isFixedIncome = false;
  bool isDisableCategory = false;
  bool isDisableCurrency = false;
  bool isChecked = false;

  void calculateCurrentValue() {
    const defaultValue = "--";
    if (noOfUnits == "" || noOfUnits == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }
    if (valuePerUnit == "" || valuePerUnit == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }

    final noOfUnitsParsed = noOfUnits != null
        ? double.tryParse(noOfUnits!.toString().replaceAll(',', ''))
        : 0;
    final valuePerUnitParsed = valuePerUnit != null
        ? double.tryParse(valuePerUnit!.toString().replaceAll(',', ''))
        : 0;
    setState(() {
      currentDayValue = NumberFormat("#,##0.##########", "en_US")
          .format(noOfUnitsParsed! * valuePerUnitParsed!);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    final bool edit = widget.edit;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ListedSecurityCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditListedAssetCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BankListCubit>()
            ..getMarketData(widget.edit ? widget.moreEntity!.securityName : ""),
        ),
        BlocProvider(
          create: (context) => sl<DontShowSettingsCubit>()..getSettings(),
        ),
      ],
      child: Builder(builder: (context) {
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
                    isChecked =
                        state.getSettingsEntities.isListedAssetEquityChecked;
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
                              "totalCost": currentDayValue,
                            };
                            if (edit) {
                              context
                                  .read<EditListedAssetCubit>()
                                  .putListedAsset(map: {
                                ...finalMap,
                                "country": widget.moreEntity?.country,
                              }, assetId: widget.moreEntity!.id);
                            } else {
                              bool add = true;
                              if (!isChecked) {
                                final conf = await showAssetConfirmationModal(
                                    context,
                                    assetType: AssetTypes.listedAsset);
                                if (conf != null &&
                                    conf.isConfirmed &&
                                    conf.isDontShowSelected) {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<DontShowSettingsCubit>()
                                      .putSettings(const PutSettingsParams(
                                          isListedAssetEquityChecked: true));
                                }
                                add = conf != null && conf.isConfirmed;
                              }
                              if (add) {
                                context
                                    .read<ListedSecurityCubit>()
                                    .postListedSecurity(map: {
                                  ...finalMap,
                                  "country": const Country(
                                      name: "XO", countryName: "Other")
                                });
                              }
                            }
                          }
                        }),
            ),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Builder(builder: (context) {
                final Widget deleteWidget = DeleteAssetBaseWidget(
                    name: AssetTypes.listedAsset,
                    realAssetName: widget.moreEntity != null
                        ? widget.moreEntity!.securityShortName
                        : "",
                    onTap: () {
                      context
                          .read<EditListedAssetCubit>()
                          .deleteListedAsset(assetId: widget.moreEntity!.id);
                    });
                return Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      child: Builder(builder: (context) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<ListedSecurityCubit,
                                ListedSecurityState>(
                              listener: AssetBlocHelper.defaultBlocListener(
                                  listener: (context, state) {},
                                  asset: "Listed asset",
                                  assetType: AssetTypes.listedAsset),
                            ),
                            BlocListener<EditListedAssetCubit,
                                    EditAssetBaseState>(
                                listener:
                                    EditAssetBlocHelper.defaultBlocListener(
                                        type: AssetTypes.listedAsset,
                                        assetId:
                                            edit ? widget.moreEntity!.id : "")),
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
                              BlocConsumer<BankListCubit, BankListState>(
                                listener: BlocHelper.defaultBlocListener(
                                    listener: (context, state) {
                                  if (state is MarketDataSuccess) {
                                    if (edit && state.entity.isNotEmpty) {
                                      try {
                                        final formJson = widget.moreEntity!
                                            .toFormJson(
                                                state.entity.first, context);
                                        securityName = formJson["name"];
                                        noOfUnits = formJson["quantity"];
                                        valuePerUnit = formJson["marketValue"];
                                        if (securityName != null) {
                                          isFixedIncome =
                                              securityName!.category ==
                                                  "FixedIncome";
                                        }
                                        isDisableCurrency = true;
                                        isDisableCategory = true;
                                      } catch (e) {
                                        debugPrint("errrrrr");
                                        debugPrint(e.toString());
                                      }
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        calculateCurrentValue();
                                        starterJson =
                                            formKey.currentState!.instantValue;
                                      });
                                    }
                                  }
                                }),
                                builder: (context, state) {
                                  return state is MarketDataSuccess
                                      ? (state.entity.isEmpty && edit)
                                          ? const NoDataWidget()
                                          : Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      (isMobile && edit)
                                                          ? deleteWidget
                                                          : const SizedBox(),
                                                      FormBuilder(
                                                        key: formKey,
                                                        initialValue: edit
                                                            ? widget.moreEntity!
                                                                .toFormJson(
                                                                    state.entity
                                                                        .first,
                                                                    context)
                                                            : AddAssetConstants
                                                                .initialJsonForAddAsset(
                                                                    context),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
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
                                                                            .assetLiabilityForms_heading_listedAssets,
                                                                        style: textTheme
                                                                            .headlineSmall,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              24),
                                                                      Text(
                                                                        appLocalizations
                                                                            .assetLiabilityForms_subHeading_listedAssets,
                                                                        style: textTheme
                                                                            .bodySmall,
                                                                      ),
                                                                    ],
                                                                  ),
                                                            Text(
                                                              appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_title,
                                                              style: textTheme
                                                                  .titleSmall,
                                                            ),
                                                            EachTextField(
                                                                tooltipText:
                                                                    appLocalizations
                                                                        .common_tooltip_security,
                                                                title: appLocalizations
                                                                    .assetLiabilityForms_forms_listedAssets_inputFields_securityName_label,
                                                                child:
                                                                    ListedSecurityTypeAhead(
                                                                        enabled:
                                                                            !edit,
                                                                        errorMsg:
                                                                            appLocalizations
                                                                                .assetLiabilityForms_forms_listedAssets_inputFields_securityName_errorMessage,
                                                                        name:
                                                                            "name",
                                                                        onChange:
                                                                            (e) {
                                                                          checkFinalValid(
                                                                              e);
                                                                          setState(
                                                                              () {
                                                                            securityName =
                                                                                e;
                                                                          });
                                                                          formKey
                                                                              .currentState!
                                                                              .patchValue({
                                                                            "currencyCode": Currency.getCurrencyList(context).firstWhere((curr) =>
                                                                                curr.symbol ==
                                                                                e?.currencyCode),
                                                                            "category":
                                                                                e?.category
                                                                          });
                                                                        },
                                                                        hint: appLocalizations
                                                                            .assetLiabilityForms_forms_listedAssets_inputFields_securityName_placeholder)),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(16),
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
                                                                          .circular(
                                                                              8)),
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
                                                                        .assetLiabilityForms_forms_listedAssets_inputFields_securityDetails_label),
                                                                    const SizedBox(
                                                                        height:
                                                                            8),
                                                                    securityName ==
                                                                            null
                                                                        ? const Text(
                                                                            "--")
                                                                        : Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(securityName?.securityName ?? ""),
                                                                                    Text(securityName?.currencyCode ?? ""),
                                                                                    Text(securityName?.category ?? "")
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(height: 5),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(securityName?.securityShortName ?? ".", style: textTheme.bodySmall),
                                                                                    const Text(" . "),
                                                                                    Text(securityName?.tradedExchange ?? ".", style: textTheme.bodySmall),
                                                                                  ],
                                                                                ),
                                                                                Text(securityName?.isin ?? ".", style: textTheme.bodySmall)
                                                                              ])
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            EachTextField(
                                                              hasInfo: false,
                                                              title: appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_inputFields_brokerName_label,
                                                              child: FormBuilderTypeAhead(
                                                                  enabled:
                                                                      !edit,
                                                                  name:
                                                                      "brokerName",
                                                                  required:
                                                                      false,
                                                                  hint: appLocalizations
                                                                      .assetLiabilityForms_forms_listedAssets_inputFields_brokerName_placeholder,
                                                                  items: AppConstants
                                                                      .custodianList),
                                                            ),
                                                            // EachTextField(
                                                            //   hasInfo: false,
                                                            //   title: appLocalizations
                                                            //       .assetLiabilityForms_forms_listedAssets_inputFields_assetType_label,
                                                            //   child: AppTextFields
                                                            //       .dropDownTextField(
                                                            //     errorMsg:
                                                            //         appLocalizations
                                                            //             .assetLiabilityForms_forms_listedAssets_inputFields_assetType_errorMessage,
                                                            //     onChanged:
                                                            //         (val) async {
                                                            //       await Future.delayed(
                                                            //           const Duration(
                                                            //               milliseconds:
                                                            //                   200));

                                                            //       if (securityName
                                                            //               ?.category ==
                                                            //           val) {
                                                            //         setState(
                                                            //             () {
                                                            //           isDisableCategory =
                                                            //               true;
                                                            //         });
                                                            //       } else {
                                                            //         setState(
                                                            //             () {
                                                            //           isDisableCategory =
                                                            //               false;
                                                            //         });
                                                            //       }

                                                            //       if (val ==
                                                            //           "FixedIncome") {
                                                            //         setState(
                                                            //             () {
                                                            //           isFixedIncome =
                                                            //               true;
                                                            //         });
                                                            //       } else {
                                                            //         formKey.currentState?.setInternalFieldValue(
                                                            //             "maturityDate",
                                                            //             null,
                                                            //             isSetState:
                                                            //                 true);
                                                            //         formKey.currentState?.setInternalFieldValue(
                                                            //             "couponRate",
                                                            //             null,
                                                            //             isSetState:
                                                            //                 true);
                                                            //         setState(
                                                            //             () {
                                                            //           isFixedIncome =
                                                            //               false;
                                                            //         });
                                                            //       }
                                                            //       checkFinalValid(
                                                            //           val);
                                                            //       debugPrint(formKey
                                                            //               .currentState!
                                                            //               .instantValue[
                                                            //           "category"]);
                                                            //     },
                                                            //     enabled:
                                                            //         !isDisableCategory,
                                                            //     name:
                                                            //         "category",
                                                            //     hint: appLocalizations
                                                            //         .assetLiabilityForms_forms_listedAssets_inputFields_assetType_placeholder,
                                                            //     items: ListedSecurityType
                                                            //         .listedSecurityList
                                                            //         .map((e) =>
                                                            //             DropdownMenuItem(
                                                            //               value:
                                                            //                   e.value,
                                                            //               child:
                                                            //                   Text(e.name),
                                                            //             ))
                                                            //         .toList(),
                                                            //   ),
                                                            // ),
                                                            EachTextField(
                                                              tooltipText:
                                                                  appLocalizations
                                                                      .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_tooltip,
                                                              title: appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_label,
                                                              child:
                                                                  AppFormBuilderDateTimePicker(
                                                                onChanged:
                                                                    (selectedDate) {
                                                                  checkFinalValid(
                                                                      selectedDate);
                                                                },
                                                                enabled: !edit,
                                                                lastDate:
                                                                    DateTime
                                                                        .now(),
                                                                inputType:
                                                                    InputType
                                                                        .date,
                                                                format: DateFormat(
                                                                    "dd/MM/yyyy"),
                                                                name:
                                                                    "investmentDate",
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                validator:
                                                                    FormBuilderValidators
                                                                        .compose([
                                                                  FormBuilderValidators.required(
                                                                      errorText:
                                                                          appLocalizations
                                                                              .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_errorMessage)
                                                                ]),
                                                                decoration:
                                                                    InputDecoration(
                                                                        suffixIcon:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                        ),
                                                                        hintText:
                                                                            appLocalizations.assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_placeholder),
                                                              ),
                                                            ),
                                                            // EachTextField(
                                                            //   hasInfo: false,
                                                            //   title: appLocalizations
                                                            //       .assetLiabilityForms_forms_listedAssets_inputFields_country_label,
                                                            //   child:
                                                            //       CountriesDropdown(
                                                            //     enabled: !widget
                                                            //         .edit,
                                                            //     onChanged:
                                                            //         checkFinalValid,
                                                            //   ),
                                                            // ),
                                                            EachTextField(
                                                              tooltipText:
                                                                  appLocalizations
                                                                      .common_tooltip_currency,
                                                              title: appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_inputFields_currency_label,
                                                              child:
                                                                  CurrenciesDropdown(
                                                                enabled:
                                                                    !isDisableCurrency,
                                                                onChanged:
                                                                    (val) {
                                                                  debugPrint(
                                                                      "currency code");
                                                                  debugPrint(val
                                                                      ?.symbol);
                                                                  debugPrint(
                                                                      securityName
                                                                          ?.currencyCode);

                                                                  if (securityName
                                                                          ?.currencyCode ==
                                                                      val?.symbol) {
                                                                    setState(
                                                                        () {
                                                                      isDisableCurrency =
                                                                          true;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      isDisableCurrency =
                                                                          false;
                                                                    });
                                                                  }

                                                                  checkFinalValid(
                                                                      val);
                                                                },
                                                              ),
                                                            ),
                                                            EachTextField(
                                                              tooltipText:
                                                                  appLocalizations
                                                                      .assetLiabilityForms_forms_listedAssets_inputFields_value_tooltip,
                                                              title: appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_inputFields_value_label,
                                                              child: AppTextFields
                                                                  .simpleTextField(
                                                                      enabled:
                                                                          !edit,
                                                                      required:
                                                                          false,
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {
                                                                          valuePerUnit =
                                                                              val;
                                                                        });
                                                                        calculateCurrentValue();
                                                                      },
                                                                      type: TextFieldType
                                                                          .rateMoney,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      name:
                                                                          "marketValue",
                                                                      hint: appLocalizations
                                                                          .assetLiabilityForms_forms_listedAssets_inputFields_value_placeholder),
                                                            ),
                                                            EachTextField(
                                                              hasInfo: false,
                                                              title: appLocalizations
                                                                  .assetLiabilityForms_forms_listedAssets_inputFields_quantity_label,
                                                              child: AppTextFields
                                                                  .simpleTextField(
                                                                      enabled:
                                                                          !edit,
                                                                      errorMsg:
                                                                          appLocalizations
                                                                              .assetLiabilityForms_forms_listedAssets_inputFields_quantity_errorMessage,
                                                                      type: TextFieldType
                                                                          .rate,
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {
                                                                          noOfUnits =
                                                                              val;
                                                                        });
                                                                        calculateCurrentValue();
                                                                        checkFinalValid(
                                                                            val);
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      name:
                                                                          "quantity",
                                                                      hint: appLocalizations
                                                                          .assetLiabilityForms_forms_listedAssets_inputFields_quantity_placeholder),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(16),
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
                                                                          .circular(
                                                                              8)),
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
                                                                        .assetLiabilityForms_forms_listedAssets_inputFields_totalCost_label),
                                                                    const SizedBox(
                                                                        height:
                                                                            8),
                                                                    Text(currentDayValue ==
                                                                            "--"
                                                                        ? currentDayValue
                                                                        : "\$$currentDayValue")
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            if (isFixedIncome)
                                                              Column(children: [
                                                                EachTextField(
                                                                  hasInfo:
                                                                      false,
                                                                  title: appLocalizations
                                                                      .assetLiabilityForms_forms_listedAssets_inputFields_couponRate_label,
                                                                  child: AppTextFields
                                                                      .simpleTextField(
                                                                    enabled:
                                                                        !edit,
                                                                    errorMsg:
                                                                        appLocalizations
                                                                            .assetLiabilityForms_forms_listedAssets_inputFields_couponRate_errorMessage_message,
                                                                    extraValidators: [
                                                                      (val) {
                                                                        return ((double.tryParse(val ?? "0") ?? 0) <=
                                                                                100)
                                                                            ? null
                                                                            : "Ownership can't be greater then 100";
                                                                      }
                                                                    ],
                                                                    type: TextFieldType
                                                                        .rate,
                                                                    onChanged:
                                                                        checkFinalValid,
                                                                    name:
                                                                        "couponRate",
                                                                    hint: "00",
                                                                    suffixIcon:
                                                                        AppTextFields
                                                                            .rateSuffixIcon(),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                EachTextField(
                                                                  hasInfo:
                                                                      false,
                                                                  title: appLocalizations
                                                                      .assetLiabilityForms_forms_listedAssets_inputFields_maturityDate_label,
                                                                  child:
                                                                      AppFormBuilderDateTimePicker(
                                                                    enabled:
                                                                        !edit,
                                                                    onChanged:
                                                                        (selectedDate) {
                                                                      checkFinalValid(
                                                                          selectedDate);
                                                                    },
                                                                    firstDate:
                                                                        DateTime
                                                                            .now(),
                                                                    inputType:
                                                                        InputType
                                                                            .date,
                                                                    format: DateFormat(
                                                                        "dd/MM/yyyy"),
                                                                    validator:
                                                                        FormBuilderValidators
                                                                            .compose([
                                                                      FormBuilderValidators.required(
                                                                          errorText:
                                                                              appLocalizations.assetLiabilityForms_forms_listedAssets_inputFields_maturityDate_errorMessage)
                                                                    ]),
                                                                    name:
                                                                        "maturityDate",
                                                                    decoration:
                                                                        InputDecoration(
                                                                            suffixIcon:
                                                                                Icon(
                                                                              Icons.calendar_month,
                                                                              color: Theme.of(context).primaryColor,
                                                                            ),
                                                                            hintText:
                                                                                appLocalizations.assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_placeholder),
                                                                  ),
                                                                ),
                                                              ]),
                                                            const SizedBox(
                                                                height: 60),
                                                          ]
                                                              .map(
                                                                  (e) =>
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                12,
                                                                            horizontal:
                                                                                16),
                                                                        child:
                                                                            e,
                                                                      ))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            )
                                      : const LoadingWidget();
                                },
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
}
