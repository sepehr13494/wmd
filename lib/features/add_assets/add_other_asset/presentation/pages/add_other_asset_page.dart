import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_form_builder_date_picker.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/manager/other_asset_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/other_asset_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_confirmation_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/other_asset/data/model/other_asset_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/presentation/manager/edit_other_assets_cubit.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/dont_show_settings/presentation/manager/dont_show_settings_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../core/presentation/pages/base_add_assest_state.dart';
import '../../../core/presentation/pages/base_add_asset_stateful_widget.dart';

class AddOtherAssetPage extends BaseAddAssetStatefulWidget {
  final OtherAseetMoreEntity? moreEntity;

  const AddOtherAssetPage({Key? key, bool edit = false, this.moreEntity})
      : super(key: key, edit: edit);

  @override
  AppState<AddOtherAssetPage> createState() => _AddOtherAssetState();
}

class _AddOtherAssetState extends BaseAddAssetState<AddOtherAssetPage> {
  String currentDayValue = "--";
  String currencySymbol = 'USD';
  String? noOfUnits = "1";
  String? valuePerUnit = "";
  String? ownerShip = "";
  String? acqusitionCost = "";
  bool isPainting = false;
  DateTime? aqusitionDateValue;
  DateTime? valuationDateValue;
  bool isChecked = false;

  void calculateCurrentValue() {
    const defaultValue = "--";
    // if (noOfUnits == "" || noOfUnits == null) {
    //   setState(() {
    //     currentDayValue = defaultValue;
    //   });
    //   return;
    // }
    // if (acqusitionCost == "" || acqusitionCost == null) {
    //   setState(() {
    //     currentDayValue = defaultValue;
    //   });
    //   return;
    // }
    // if (ownerShip == "" || ownerShip == null) {
    //   setState(() {
    //     currentDayValue = defaultValue;
    //   });
    //   return;
    // }

    // final noOfUnitsParsed =
    //     noOfUnits != null ? ((int.tryParse(noOfUnits!)) ?? 0) : 0;
    final valuePerUnitParsed = (valuePerUnit != null && valuePerUnit != "")
        ? int.tryParse(valuePerUnit!.toString().replaceAll(',', ''))
        : 0;
    final acqusitionCostParsed = acqusitionCost != null
        ? int.tryParse(acqusitionCost!.toString().replaceAll(',', ''))
        : 0;
    // final ownerShipParsed = ownerShip != null
    //     ? double.tryParse(ownerShip!.toString().replaceAll(',', ''))
    //     : 0;
    const ownerShipParsed = 100;
    const noOfUnitsParsed = 1;

    setState(() {
      if (valuePerUnit != null && valuePerUnit != "") {
        currentDayValue = NumberFormat("#,##0", "en_US").format(
            (noOfUnitsParsed * valuePerUnitParsed!) * (ownerShipParsed / 100));
      } else if (acqusitionCost != "" && acqusitionCost != null) {
        currentDayValue = NumberFormat("#,##0", "en_US").format(
            (noOfUnitsParsed * acqusitionCostParsed!) *
                (ownerShipParsed / 100));
      }
    });
  }

  @override
  void initState() {
    if (widget.edit) {
      if (widget.moreEntity!.toFormJson(context)["assetType"] == "Painting") {
        isPainting = true;
      }
      noOfUnits = widget.moreEntity!.toFormJson(context)["units"];
      acqusitionCost =
          widget.moreEntity!.toFormJson(context)["acquisitionCost"];
      ownerShip = widget.moreEntity!.toFormJson(context)["ownerShip"];
      valuePerUnit = widget.moreEntity!.toFormJson(context)["valuePerUnit"];
      calculateCurrentValue();
    }
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool edit = widget.edit;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<OtherAssetCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditOtherAssetsCubit>(),
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
                    isChecked = state.getSettingsEntities.isOtherAssetsChecked;
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
                              "currentDayValue": currentDayValue == "--"
                                  ? "0"
                                  : currentDayValue
                            };
                            if (edit) {
                              context
                                  .read<EditOtherAssetsCubit>()
                                  .putOtherAssets(map: {
                                ...finalMap,
                                "ownershipPercentage": widget
                                    .moreEntity?.ownerShip
                                    .toStringAsFixedZero(0),
                                "noOfUnits": widget.moreEntity?.units
                                    .toStringAsFixedZero(0),
                              }, assetId: widget.moreEntity!.id);
                            } else {
                              bool add = true;
                              if (!isChecked) {
                                final conf = await showAssetConfirmationModal(
                                    context,
                                    assetType: AssetTypes.otherAsset);
                                if (conf != null &&
                                    conf.isConfirmed &&
                                    conf.isDontShowSelected) {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<DontShowSettingsCubit>()
                                      .putSettings(const PutSettingsParams(
                                          isOtherAssetsChecked: true));
                                }
                                add = conf != null && conf.isConfirmed;
                              }
                              if (add) {
                                // ignore: use_build_context_synchronously
                                context.read<OtherAssetCubit>().postOtherAsset(
                                    map: {
                                      ...finalMap,
                                      "ownerShip": "100",
                                      "units": "1"
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
                    name: AssetTypes.otherAsset,
                    realAssetName: widget.moreEntity != null
                        ? widget.moreEntity!.name
                        : "",
                    onTap: () {
                      context
                          .read<EditOtherAssetsCubit>()
                          .deleteOtherAssets(assetId: widget.moreEntity!.id);
                    });
                return Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      child: Builder(builder: (context) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<OtherAssetCubit, OtherAssetState>(
                                listener: AssetBlocHelper.defaultBlocListener(
                                    listener: (context, state) {},
                                    asset: "Other asset",
                                    assetType: AssetTypes.otherAssets)),
                            BlocListener<EditOtherAssetsCubit,
                                    EditAssetBaseState>(
                                listener:
                                    EditAssetBlocHelper.defaultBlocListener(
                                        type: AssetTypes.otherAsset,
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
                                                  .initialJsonForAddOtherAsset(
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
                                                              .assetLiabilityForms_heading_others,
                                                          style: textTheme
                                                              .headlineSmall,
                                                        ),
                                                        const SizedBox(
                                                            height: 24),
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_subHeading_others,
                                                          style: textTheme
                                                              .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                              Text(
                                                appLocalizations
                                                    .assetLiabilityForms_forms_others_title,
                                                style: textTheme.titleSmall,
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_name_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_name_errorMessage,
                                                        title: "Name",
                                                        name: "name",
                                                        onChanged:
                                                            checkFinalValid,
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
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_name_placeholder),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_wealthManager_label,
                                                child: FormBuilderTypeAhead(
                                                    enabled: !edit,
                                                    name: "wealthManager",
                                                    required: false,
                                                    hint: appLocalizations
                                                        .assetLiabilityForms_forms_others_inputFields_wealthManager_placeholder,
                                                    items: AppConstants
                                                        .custodianList),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_assetType_label,
                                                child: AppTextFields
                                                    .dropDownTextField(
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_assetType_errorMessage,
                                                  onChanged: (val) async {
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 200));
                                                    checkFinalValid(val);

                                                    if (val == "Painting") {
                                                      setState(() {
                                                        isPainting = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isPainting = false;
                                                      });
                                                    }
                                                  },
                                                  name: "assetType",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_assetType_placeholder,
                                                  items: OtherAssetType
                                                          .otherAssetList(
                                                              context)
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e.value,
                                                            child: Text(e.name),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                              if (isPainting)
                                                EachTextField(
                                                  tooltipText: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_valuationDate_tooltip,
                                                  title: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_valuationDate_label,
                                                  child:
                                                      AppFormBuilderDateTimePicker(
                                                    enabled: !(edit &&
                                                        starterJson[
                                                                "assetType"] ==
                                                            'Painting'),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        valuationDateValue =
                                                            val;
                                                      });
                                                      checkFinalValid(val);
                                                    },
                                                    firstDate:
                                                        aqusitionDateValue,
                                                    lastDate: DateTime.now(),
                                                    inputType: InputType.date,
                                                    initialValue:
                                                        DateTime.now(),
                                                    format: DateFormat(
                                                        "dd/MM/yyyy"),
                                                    name: "valuationDate",
                                                    decoration: InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.calendar_month,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        hintText: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_valuationDate_placeholder),
                                                  ),
                                                ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_country_label,
                                                child: CountriesDropdown(
                                                  enabled: !widget.edit,
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .common_tooltip_currency,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_currency_label,
                                                child: CurrenciesDropdown(
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      setState(() {
                                                        currencySymbol =
                                                            value.symbol;
                                                      });
                                                    }
                                                    checkFinalValid(value);
                                                  },
                                                  enabled: AppConstants
                                                          .currencyConvertor &&
                                                      !edit,
                                                ),
                                              ),
                                              /* EachTextField(
                                                 hasInfo: false,
                                                 title: appLocalizations
                                                     .assetLiabilityForms_forms_others_inputFields_units_label,
                                                 child: AppTextFields
                                                     .simpleTextField(
                                                         enabled: !edit,
                                                         type: TextFieldType
                                                             .number,
                                                         onChanged: (val) {
                                                           setState(() {
                                                             noOfUnits = val;
                                                           });
                                                           calculateCurrentValue();
                                                           checkFinalValid(val);
                                                         },
                                                         keyboardType:
                                                             TextInputType
                                                                 .number,
                                                         name: "units",
                                                         hint: appLocalizations
                                                             .assetLiabilityForms_forms_others_inputFields_units_placeholder),
                                               ),*/
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_acquisitionCost_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_acquisitionCost_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        enabled: !edit,
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_acquisitionCost_errorMessage,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            acqusitionCost =
                                                                val;
                                                          });
                                                          calculateCurrentValue();

                                                          checkFinalValid(val);
                                                        },
                                                        type:
                                                            TextFieldType.money,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        name: "acquisitionCost",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_acquisitionCost_placeholder),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_acquisitionDate_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_acquisitionDate_label,
                                                child:
                                                    AppFormBuilderDateTimePicker(
                                                  enabled: !edit,
                                                  onChanged: (selectedDate) {
                                                    checkFinalValid(
                                                        selectedDate);
                                                    setState(() {
                                                      aqusitionDateValue =
                                                          selectedDate;
                                                    });
                                                  },
                                                  initialDate:
                                                      valuationDateValue ??
                                                          DateTime.now(),
                                                  lastDate:
                                                      valuationDateValue ??
                                                          DateTime.now(),
                                                  inputType: InputType.date,
                                                  format:
                                                      DateFormat("dd/MM/yyyy"),
                                                  name: "acquisitionDate",
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      hintText: appLocalizations
                                                          .assetLiabilityForms_forms_others_inputFields_acquisitionDate_placeholder),
                                                ),
                                              ),
                                              /*EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_ownerShip_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        enabled: !edit,
                                                        extraValidators: [
                                                          (val) {
                                                            return ((int.tryParse(val ??
                                                                            "0") ??
                                                                        0) <=
                                                                    100)
                                                                ? null
                                                                : "Ownership can't be greater then 100";
                                                          }
                                                        ],
                                                        type: TextFieldType
                                                            .number,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            ownerShip = val;
                                                          });
                                                          calculateCurrentValue();
                                                        },
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_ownerShip_errorMessageRequired,
                                                        suffixIcon: AppTextFields
                                                            .rateSuffixIcon(),
                                                        name: "ownerShip",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_ownerShip_placeholder),
                                              ),*/
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_valuePerUnit_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        enabled: !edit,
                                                        required: false,
                                                        type:
                                                            TextFieldType.money,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            valuePerUnit = val;
                                                          });
                                                          calculateCurrentValue();
                                                        },
                                                        name: "valuePerUnit",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_others_inputFields_valuePerUnit_placeholder),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? AppColors
                                                            .anotherCardColorForDarkTheme
                                                        : AppColors
                                                            .anotherCardColorForLightTheme,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                          .assetLiabilityForms_forms_others_inputFields_currentDayValue_label),
                                                      const SizedBox(height: 8),
                                                      Text(currentDayValue !=
                                                              "--"
                                                          ? "$currencySymbol $currentDayValue"
                                                          : currentDayValue)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 60),
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
}
