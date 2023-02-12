import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/real_estate_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';

class AddRealEstatePage extends StatefulWidget {
  const AddRealEstatePage({Key? key}) : super(key: key);
  @override
  AppState<AddRealEstatePage> createState() => _AddRealEstateState();
}

class _AddRealEstateState extends AppState<AddRealEstatePage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  DateTime? aqusitionDateValue;
  @override
  void didUpdateWidget(covariant AddRealEstatePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = privateDebtFormKey.currentState!.isValid;
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

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<RealEstateCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(title: "", showExitModal: true),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: !enableAddAssetButton ? null : () {
                privateDebtFormKey.currentState?.validate();
                if (enableAddAssetButton) {
                  Map<String, dynamic> finalMap = {
                    ...privateDebtFormKey.currentState!.instantValue,
                  };

                  print(finalMap);

                  context.read<RealEstateCubit>().postRealEstate(map: finalMap);
                }
              }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<RealEstateCubit, RealEstateState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Real estate",
                            assetType: AssetTypes.realEstate),
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(children: [
                              FormBuilder(
                                key: privateDebtFormKey,
                                initialValue:
                                    AddAssetConstants.initialJsonForAddAsset,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_heading_realEstate,
                                      style: textTheme.headlineSmall,
                                    ),
                                    Text(
                                      appLocalizations
                                          .manage_assetAndLiability_assetAndLiabilityList_realEstate_description,
                                      style: textTheme.bodySmall,
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
                                      child: AppTextFields.simpleTextField(
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
                                              .assetLiabilityForms_forms_realEstate_inputFields_name_placeholder),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_label,
                                      child: AppTextFields.dropDownTextField(
                                        onChanged: (val) async {
                                          // setState(() {
                                          //   bottomFormKey =
                                          //       GlobalKey<FormBuilderState>();
                                          //   accountType = val;
                                          // });
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));
                                          checkFinalValid(val);
                                        },
                                        name: "realEstateType",
                                        hint: appLocalizations
                                            .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_placeholder,
                                        items: RealEstateType.realEstateList
                                            .map((e) => DropdownMenuItem(
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
                                      child: AppTextFields.simpleTextField(
                                          title: "Address",
                                          name: "address",
                                          required: false,
                                          // onChanged: checkFinalValid,
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_realEstate_inputFields_address_placeholder),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_country_label,
                                      child: CountriesDropdown(
                                        onChanged: checkFinalValid,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_currency_label,
                                      child: CurrenciesDropdown(
                                        onChanged: checkFinalValid,
                                        showExchange: true,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_label,
                                      child: AppTextFields.simpleTextField(
                                          type: TextFieldType.number,
                                          keyboardType: TextInputType.number,
                                          onChanged: checkFinalValid,
                                          name: "noOfUnits",
                                          extraValidators: [
                                            (val) {
                                              return ((int.tryParse(
                                                              val ?? "0") ??
                                                          0) <=
                                                      100)
                                                  ? null
                                                  : "${appLocalizations.assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_label} can't be greater then 100";
                                            }
                                          ],
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_label,
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "acquisitionCostPerUnit",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_realEstate_inputFields_acquisitionCostPerUnit_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_label,
                                      child: FormBuilderDateTimePicker(
                                        onChanged: (selectedDate) {
                                          checkFinalValid(selectedDate);
                                          setState(() {
                                            aqusitionDateValue = selectedDate;
                                          });
                                        },
                                        lastDate: DateTime.now(),
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        name: "acquisitionDate",
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required()
                                        ]),
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: appLocalizations
                                                .assetLiabilityForms_forms_realEstate_inputFields_acquisitionDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_yourOwnership_label,
                                      child: AppTextFields.simpleTextField(
                                          extraValidators: [
                                            (val) {
                                              return ((int.tryParse(
                                                              val ?? "0") ??
                                                          0) <=
                                                      100)
                                                  ? null
                                                  : "Ownership can't be greater then 100";
                                            }
                                          ],
                                          type: TextFieldType.number,
                                          keyboardType: TextInputType.number,
                                          onChanged: checkFinalValid,
                                          name: "ownershipPercentage",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_realEstate_inputFields_yourOwnership_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_label,
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "marketValue",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_realEstate_inputFields_valuationDate_label,
                                      child: FormBuilderDateTimePicker(
                                        firstDate: aqusitionDateValue,
                                        lastDate: DateTime.now(),
                                        format: DateFormat("dd/MM/yyyy"),
                                        inputType: InputType.date,
                                        name: "valuationDate",
                                        onChanged: checkFinalValid,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: e,
                                          ))
                                      .toList(),
                                ),
                              ),
                            ]),
                          );
                        });
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
