import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_form_builder_date_picker.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/real_estate_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/real_estate/data/model/real_estate_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/presentation/manager/edit_real_estate_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../../edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import '../../../core/presentation/pages/base_add_assest_state.dart';
import '../../../core/presentation/pages/base_add_asset_stateful_widget.dart';

class AddRealEstatePage extends BaseAddAssetStatefulWidget {
  final RealEstateMoreEntity? moreEntity;

  const AddRealEstatePage({Key? key, bool edit = false, this.moreEntity})
      : super(key: key, edit: edit);

  @override
  AppState<AddRealEstatePage> createState() => _AddRealEstateState();
}

class _AddRealEstateState extends BaseAddAssetState<AddRealEstatePage> {
  DateTime? aqusitionDateValue;
  DateTime? valuationDateValue;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool edit = widget.edit;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RealEstateCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditRealEstateCubit>(),
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
                    ? appLocalizations.common_button_save
                    : appLocalizations.common_button_addAsset,
                onTap: (edit && !enableAddAssetButtonEdit)
                    ? null
                    : () {
                        formKey.currentState?.validate();
                        if (enableAddAssetButton) {
                          Map<String, dynamic> finalMap = {
                            ...formKey.currentState!.instantValue,
                          };

                          debugPrint(finalMap.toString());

                          if (edit) {
                            context
                                .read<EditRealEstateCubit>()
                                .putRealEstate(map: {
                              ...finalMap,
                              "ownershipPercentage": widget
                                  .moreEntity?.ownershipPercentage
                                  .toStringAsFixedZero(0),
                              "noOfUnits": widget.moreEntity?.noOfUnits
                                  .toStringAsFixedZero(0),
                            }, assetId: widget.moreEntity!.id);
                          } else {
                            context
                                .read<RealEstateCubit>()
                                .postRealEstate(map: {
                              ...finalMap,
                              "ownershipPercentage": "100",
                              "noOfUnits": "1",
                            });
                          }
                        }
                      }),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Builder(builder: (context) {
                final Widget deleteWidget = DeleteAssetBaseWidget(
                    name: AssetTypes.realEstate,
                    realAssetName: widget.moreEntity != null
                        ? widget.moreEntity!.name
                        : "",
                    onTap: () {
                      context
                          .read<EditRealEstateCubit>()
                          .deleteRealEstate(assetId: widget.moreEntity!.id);
                    });
                return Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      width: edit ? 1000 : 500,
                      child: Builder(builder: (context) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<RealEstateCubit, RealEstateState>(
                              listener: AssetBlocHelper.defaultBlocListener(
                                  listener: (context, state) {},
                                  asset: "Real estate",
                                  assetType: AssetTypes.realEstate),
                            ),
                            BlocListener<EditRealEstateCubit,
                                EditAssetBaseState>(
                              listener: EditAssetBlocHelper.defaultBlocListener(
                                  type: AssetTypes.realEstate,
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
                                                  .initialJsonForAddAsset,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              edit
                                                  ? const SizedBox()
                                                  : Column(
                                                      children: [
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_heading_realEstate,
                                                          style: textTheme
                                                              .headlineSmall,
                                                        ),
                                                        const SizedBox(
                                                            height: 24),
                                                        Text(
                                                          appLocalizations
                                                              .manage_assetAndLiability_assetAndLiabilityList_realEstate_description,
                                                          style: textTheme
                                                              .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                              Text(
                                                appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_title,
                                                style: textTheme.titleSmall,
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_name_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                  title: "Name",
                                                  name: "name",
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_realEstate_inputFields_name_errorMessage,
                                                  onChanged: checkFinalValid,
                                                  extraValidators: [
                                                    (val) {
                                                      return (val != null &&
                                                              val.length > 50)
                                                          ? appLocalizations
                                                              .common_errors_maxChar
                                                              .replaceAll(
                                                                  "{{maxChar}}",
                                                                  "50")
                                                          : null;
                                                    }
                                                  ],
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_realEstate_inputFields_name_placeholder,
                                                ),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_label,
                                                child: AppTextFields
                                                    .dropDownTextField(
                                                  errorMsg: appLocalizations
                                                      .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_errorMessage,
                                                  onChanged: (val) async {
                                                    // setState(() {
                                                    //   bottomFormKey =
                                                    //       GlobalKey<FormBuilderState>();
                                                    //   accountType = val;
                                                    // });
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 200));
                                                    checkFinalValid(val);
                                                  },
                                                  name: "realEstateType",
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_placeholder,
                                                  items: RealEstateType
                                                          .realEstateList(
                                                              context)
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e.value,
                                                            child: Text(e.name),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_address_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        title: "Address",
                                                        name: "address",
                                                        required: false,
                                                        onChanged:
                                                            checkFinalValid,
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_realEstate_inputFields_address_placeholder),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_country_label,
                                                child: CountriesDropdown(
                                                  enabled: !edit,
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_currency_label,
                                                child: CurrenciesDropdown(
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              // EachTextField(
                                              //   hasInfo: false,
                                              //   title: appLocalizations
                                              //       .assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_label,
                                              //   child: AppTextFields
                                              //       .simpleTextField(
                                              //           enabled: !edit,
                                              //           type: TextFieldType
                                              //               .number,
                                              //           keyboardType:
                                              //               TextInputType
                                              //                   .number,
                                              //           onChanged:
                                              //               checkFinalValid,
                                              //           name: "noOfUnits",
                                              //           extraValidators: [
                                              //             (val) {
                                              //               return ((int.tryParse(val ??
                                              //                               "0") ??
                                              //                           0) <=
                                              //                       100)
                                              //                   ? null
                                              //                   : "\${appLocalizations.assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_label} can't be greater then 100";
                                              //             }
                                              //           ],
                                              //           hint: appLocalizations
                                              //               .assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_placeholder),
                                              // ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_label,
                                                child: AppTextFields.simpleTextField(
                                                    enabled: !edit,
                                                    errorMsg: appLocalizations
                                                        .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_errorMessage,
                                                    onChanged: checkFinalValid,
                                                    type: TextFieldType.money,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    name:
                                                        "acquisitionCostPerUnit",
                                                    hint: appLocalizations
                                                        .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_placeholder),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_label,
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
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators.required(
                                                        errorText: appLocalizations
                                                            .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_errorMessage)
                                                  ]),
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      hintText: appLocalizations
                                                          .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_placeholder),
                                                ),
                                              ),
                                              // EachTextField(
                                              //   hasInfo: false,
                                              //   title: appLocalizations
                                              //       .assetLiabilityForms_forms_realEstate_inputFields_yourOwnership_label,
                                              //   child: AppTextFields
                                              //       .simpleTextField(
                                              //           enabled: !edit,
                                              //           extraValidators: [
                                              //             (val) {
                                              //               return ((int.tryParse(val ??
                                              //                               "0") ??
                                              //                           0) <=
                                              //                       100)
                                              //                   ? null
                                              //                   : "Ownership can't be greater then 100";
                                              //             }
                                              //           ],
                                              //           type: TextFieldType
                                              //               .number,
                                              //           keyboardType:
                                              //               TextInputType
                                              //                   .number,
                                              //           onChanged:
                                              //               checkFinalValid,
                                              //           suffixIcon: AppTextFields
                                              //               .rateSuffixIcon(),
                                              //           name:
                                              //               "ownershipPercentage",
                                              //           hint: appLocalizations
                                              //               .assetLiabilityForms_forms_realEstate_inputFields_yourOwnership_placeholder),
                                              // ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_tooltip,
                                                title: widget.edit
                                                    ? appLocalizations
                                                        .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_initialMarketValueLabel
                                                    : appLocalizations
                                                        .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        enabled: !edit,
                                                        required: false,
                                                        type:
                                                            TextFieldType.money,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        name: "marketValue",
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_placeholder),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_valuationDate_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_realEstate_inputFields_valuationDate_label,
                                                child:
                                                    AppFormBuilderDateTimePicker(
                                                  enabled: !edit,
                                                  firstDate: aqusitionDateValue,
                                                  lastDate: DateTime.now(),
                                                  format:
                                                      DateFormat("dd/MM/yyyy"),
                                                  inputType: InputType.date,
                                                  name: "valuationDate",
                                                  onChanged: (selectedDate) {
                                                    checkFinalValid(
                                                        selectedDate);
                                                    setState(() {
                                                      valuationDateValue =
                                                          selectedDate;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      hintText: appLocalizations
                                                          .assetLiabilityForms_forms_realEstate_inputFields_valuationDate_placeholder),
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
