import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
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
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/other_asset/data/model/other_asset_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/presentation/manager/edit_other_assets_cubit.dart';
import 'package:wmd/injection_container.dart';

class AddOtherAssetPage extends StatefulWidget {
  final bool edit;
  final OtherAseetMoreEntity? moreEntity;

  const AddOtherAssetPage({Key? key, this.edit = false, this.moreEntity})
      : super(key: key);

  @override
  AppState<AddOtherAssetPage> createState() => _AddOtherAssetState();
}

class _AddOtherAssetState extends AppState<AddOtherAssetPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  String currentDayValue = "--";
  String? noOfUnits = "1";
  String? valuePerUnit = "";
  String? ownerShip = "";
  String? acqusitionCost = "";
  bool isPainting = false;
  DateTime? aqusitionDateValue;
  DateTime? valuationDateValue;

  @override
  void didUpdateWidget(covariant AddOtherAssetPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    if (finalValid) {
      if (!enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = true;
        });
      }
    } else {
      if (enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = false;
        });
      }
    }
  }

  void calculateCurrentValue() {
    const defaultValue = "--";
    if (noOfUnits == "" || noOfUnits == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }
    if (acqusitionCost == "" || acqusitionCost == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }
    if (ownerShip == "" || ownerShip == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }

    final noOfUnitsParsed =
        noOfUnits != null ? ((int.tryParse(noOfUnits!)) ?? 0) : 0;
    final valuePerUnitParsed = valuePerUnit != null
        ? int.tryParse(valuePerUnit!.toString().replaceAll(',', ''))
        : 0;
    final acqusitionCostParsed = acqusitionCost != null
        ? int.tryParse(acqusitionCost!.toString().replaceAll(',', ''))
        : 0;
    final ownerShipParsed = ownerShip != null
        ? double.tryParse(ownerShip!.toString().replaceAll(',', ''))
        : 0;

    setState(() {
      if (valuePerUnit != null && valuePerUnit != "") {
        currentDayValue = NumberFormat("#,##0", "en_US").format(
            (noOfUnitsParsed * valuePerUnitParsed!) * (ownerShipParsed! / 100));
      } else {
        currentDayValue = NumberFormat("#,##0", "en_US").format(
            (noOfUnitsParsed * acqusitionCostParsed!) *
                (ownerShipParsed! / 100));
      }
    });
  }

  @override
  void initState() {
    if (widget.edit) {
      if (widget.moreEntity!.toFormJson()["assetType"] == "Painting") {
        isPainting = true;
      }
      noOfUnits = widget.moreEntity!.toFormJson()["units"];
      acqusitionCost = widget.moreEntity!.toFormJson()["acquisitionCost"];
      ownerShip = widget.moreEntity!.toFormJson()["ownerShip"];
      valuePerUnit = widget.moreEntity!.toFormJson()["valuePerUnit"];
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
      ],
      child: Builder(builder: (context) {
        final bool isMobile = ResponsiveHelper(context: context).isMobile;
        return WillPopScope(
          onWillPop: () {
            return handleAssetBackButton(context);
          },
          child: Scaffold(
            appBar: const AddAssetHeader(title: "", showExitModal: true),
            bottomSheet: AddAssetFooter(
                buttonText: edit
                    ? "Save Asset"
                    : appLocalizations.common_button_addAsset,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Map<String, dynamic> finalMap = {
                      ...formKey.currentState!.instantValue,
                      "currentDayValue":
                          currentDayValue == "--" ? "0" : currentDayValue
                    };
                    if (edit) {
                      context.read<EditOtherAssetsCubit>().putOtherAssets(
                          map: finalMap, assetId: widget.moreEntity!.id);
                    } else {
                      context
                          .read<OtherAssetCubit>()
                          .postOtherAsset(map: finalMap);
                    }
                  }
                }),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Builder(
                builder: (context) {
                  final Widget deleteWidget = DeleteAssetBaseWidget(
                      name: "Bank account",
                      onTap: () {
                        context
                            .read<EditOtherAssetsCubit>()
                            .deleteOtherAssets(
                            assetId:
                            widget.moreEntity!.id);
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
                                  listener: EditAssetBlocHelper.defaultBlocListener(
                                      assetId: edit ? widget.moreEntity!.id : "")),
                            ],
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (!isMobile && edit) ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    deleteWidget,
                                    Container(margin: const EdgeInsets.only(top: 32),width: 0.7,height: 200,color: Theme.of(context).dividerColor,),
                                  ],
                                ) : const SizedBox(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          (isMobile &&  edit)
                                              ? deleteWidget
                                              : const SizedBox(),
                                      FormBuilder(
                                        key: formKey,
                                        initialValue: edit
                                            ? widget.moreEntity!.toFormJson()
                                            : AddAssetConstants
                                                .initialJsonForAddOtherAsset,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            edit ? const SizedBox() : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appLocalizations
                                                      .assetLiabilityForms_heading_others,
                                                  style: textTheme.headlineSmall,
                                                ),
                                                const SizedBox(height: 24),
                                                Text(
                                                  appLocalizations
                                                      .assetLiabilityForms_subHeading_others,
                                                  style: textTheme.bodySmall,
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
                                              child: AppTextFields.simpleTextField(
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_name_errorMessage,
                                                  title: "Name",
                                                  name: "name",
                                                  onChanged: checkFinalValid,
                                                  extraValidators: [
                                                    (val) {
                                                      return (val != null &&
                                                              val.length > 100)
                                                          ? "Name cannot be more than 100 characters"
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
                                                  items: AppConstants.custodianList),
                                            ),
                                            EachTextField(
                                              hasInfo: false,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_assetType_label,
                                              child: AppTextFields.dropDownTextField(
                                                errorMsg: appLocalizations
                                                    .assetLiabilityForms_forms_others_inputFields_assetType_errorMessage,
                                                onChanged: (val) async {
                                                  await Future.delayed(
                                                      const Duration(milliseconds: 200));
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
                                                items: OtherAssetType.otherAssetList
                                                    .map((e) => DropdownMenuItem(
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
                                                child: FormBuilderDateTimePicker(
                                                  onChanged: (val) {
                                                    setState(() {
                                                      valuationDateValue = val;
                                                    });
                                                    checkFinalValid(val);
                                                  },
                                                  firstDate: aqusitionDateValue,
                                                  lastDate: DateTime.now(),
                                                  inputType: InputType.date,
                                                  initialValue: DateTime.now(),
                                                  format: DateFormat("dd/MM/yyyy"),
                                                  name: "valuationDate",
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        color: Theme.of(context)
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
                                                onChanged: checkFinalValid,
                                              ),
                                            ),
                                            EachTextField(
                                              hasInfo: false,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_currency_label,
                                              child: CurrenciesDropdown(
                                                onChanged: checkFinalValid,
                                                showExchange: true,
                                              ),
                                            ),
                                            EachTextField(
                                              hasInfo: false,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_units_label,
                                              child: AppTextFields.simpleTextField(
                                                  enabled: !edit,
                                                  type: TextFieldType.number,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      noOfUnits = val;
                                                    });
                                                    calculateCurrentValue();
                                                    checkFinalValid(val);
                                                  },
                                                  keyboardType: TextInputType.number,
                                                  name: "units",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_units_placeholder),
                                            ),
                                            EachTextField(
                                              tooltipText: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_acquisitionCost_tooltip,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_acquisitionCost_label,
                                              child: AppTextFields.simpleTextField(
                                                  enabled: !edit,
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_acquisitionCost_errorMessage,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      acqusitionCost = val;
                                                    });
                                                    calculateCurrentValue();

                                                    checkFinalValid(val);
                                                  },
                                                  type: TextFieldType.money,
                                                  keyboardType: TextInputType.number,
                                                  name: "acquisitionCost",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_acquisitionCost_placeholder),
                                            ),
                                            EachTextField(
                                              tooltipText: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_acquisitionDate_tooltip,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_acquisitionDate_label,
                                              child: FormBuilderDateTimePicker(
                                                enabled: !edit,
                                                onChanged: (selectedDate) {
                                                  checkFinalValid(selectedDate);
                                                  setState(() {
                                                    aqusitionDateValue = selectedDate;
                                                  });
                                                },
                                                initialDate:
                                                    valuationDateValue ?? DateTime.now(),
                                                lastDate:
                                                    valuationDateValue ?? DateTime.now(),
                                                inputType: InputType.date,
                                                format: DateFormat("dd/MM/yyyy"),
                                                name: "acquisitionDate",
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.calendar_month,
                                                      color:
                                                          Theme.of(context).primaryColor,
                                                    ),
                                                    hintText: appLocalizations
                                                        .assetLiabilityForms_forms_others_inputFields_acquisitionDate_placeholder),
                                              ),
                                            ),
                                            EachTextField(
                                              hasInfo: false,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_ownerShip_label,
                                              child: AppTextFields.simpleTextField(
                                                  enabled: !edit,
                                                  extraValidators: [
                                                    (val) {
                                                      return ((int.tryParse(val ?? "0") ??
                                                                  0) <=
                                                              100)
                                                          ? null
                                                          : "Ownership can't be greater then 100";
                                                    }
                                                  ],
                                                  type: TextFieldType.number,
                                                  keyboardType: TextInputType.number,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      ownerShip = val;
                                                    });
                                                    calculateCurrentValue();
                                                  },
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_ownerShip_errorMessageRequired,
                                                  suffixIcon:
                                                      AppTextFields.rateSuffixIcon(),
                                                  name: "ownerShip",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_others_inputFields_ownerShip_placeholder),
                                            ),
                                            EachTextField(
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_others_inputFields_valuePerUnit_label,
                                              child: AppTextFields.simpleTextField(
                                                  enabled: !edit,
                                                  required: true,
                                                  type: TextFieldType.money,
                                                  keyboardType: TextInputType.number,
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
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).brightness ==
                                                          Brightness.dark
                                                      ? AppColors
                                                          .anotherCardColorForDarkTheme
                                                      : AppColors
                                                          .anotherCardColorForLightTheme,
                                                  borderRadius: BorderRadius.circular(8)),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional.centerStart,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(appLocalizations
                                                        .assetLiabilityForms_forms_others_inputFields_currentDayValue_label),
                                                    const SizedBox(height: 8),
                                                    Text(currentDayValue)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                          ]
                                              .map((e) => Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 12, horizontal: 16),
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
                }
              ),
            ),
          ),
        );
      }),
    );
  }
}
