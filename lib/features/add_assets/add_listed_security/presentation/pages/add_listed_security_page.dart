import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/manager/listed_security_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';

class AddListedSecurityPage extends StatefulWidget {
  const AddListedSecurityPage({Key? key}) : super(key: key);
  @override
  AppState<AddListedSecurityPage> createState() => _AddListedSecurityState();
}

class _AddListedSecurityState extends AppState<AddListedSecurityPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  String currentDayValue = "--";
  String? noOfUnits = "";
  String? valuePerUnit = "";
  ListedSecurityName? securityName;
  bool isFixedIncome = false;
  bool isDisableCategory = false;
  bool isDisableCurrency = false;
  @override
  void didUpdateWidget(covariant AddListedSecurityPage oldWidget) {
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
    if (valuePerUnit == "" || valuePerUnit == null) {
      setState(() {
        currentDayValue = defaultValue;
      });
      return;
    }

    final noOfUnitsParsed = noOfUnits != null ? int.tryParse(noOfUnits!) : 0;
    final valuePerUnitParsed = valuePerUnit != null
        ? int.tryParse(valuePerUnit!.toString().replaceAll(',', ''))
        : 0;

    setState(() {
      currentDayValue = NumberFormat("#,##0", "en_US")
          .format(noOfUnitsParsed! * valuePerUnitParsed!);
    });
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ListedSecurityCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => sl<ListedSecurityCubit>()..getListedSecurity(""),
        // )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(title: "", showExitModal: true),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: () {
                formKey.currentState?.validate();
                if (enableAddAssetButton) {
                  Map<String, dynamic> finalMap = {
                    ...formKey.currentState!.instantValue,
                    "totalCost": currentDayValue,
                  };

                  print("finalMap");
                  print(finalMap);

                  context
                      .read<ListedSecurityCubit>()
                      .postListedSecurity(map: finalMap);
                }
              }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<ListedSecurityCubit,
                            ListedSecurityState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Listed asset",
                            assetType: AssetTypes.listedAsset),
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(children: [
                              FormBuilder(
                                key: formKey,
                                initialValue:
                                    AddAssetConstants.initialJsonForAddAsset,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_heading_listedAssets,
                                      style: textTheme.headlineSmall,
                                    ),
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_subHeading_listedAssets,
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_title,
                                      style: textTheme.titleSmall,
                                    ),
                                    EachTextField(
                                        hasInfo: false,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_listedAssets_inputFields_securityName_label,
                                        child: ListedSecurityTypeAhead(
                                            name: "name",
                                            onChange: (e) {
                                              checkFinalValid(e);
                                              setState(() {
                                                securityName = e;
                                              });
                                              formKey.currentState!.patchValue({
                                                "currencyCode": Currency
                                                    .currenciesList
                                                    .firstWhere((curr) =>
                                                        curr.symbol ==
                                                        e?.currencyCode),
                                                "category": e?.category
                                              });
                                            },
                                            items: ListedSecurityName
                                                .listedSecurityNameList,
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_listedAssets_inputFields_securityName_placeholder)),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors
                                                  .anotherCardColorForDarkTheme
                                              : AppColors
                                                  .anotherCardColorForLightTheme,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Security details"),
                                            const SizedBox(height: 8),
                                            securityName == null
                                                ? const Text("--")
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(securityName
                                                                    ?.securityName ??
                                                                ""),
                                                            Text(securityName
                                                                    ?.currencyCode ??
                                                                ""),
                                                            Text(securityName
                                                                    ?.category ??
                                                                "")
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                securityName
                                                                        ?.securityShortName ??
                                                                    ".",
                                                                style: textTheme
                                                                    .bodySmall),
                                                            const Text(" . "),
                                                            Text(
                                                                securityName
                                                                        ?.tradedExchange ??
                                                                    ".",
                                                                style: textTheme
                                                                    .bodySmall),
                                                          ],
                                                        ),
                                                        Text(
                                                            securityName
                                                                    ?.isin ??
                                                                ".",
                                                            style: textTheme
                                                                .bodySmall)
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
                                          name: "brokerName",
                                          required: false,
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_listedAssets_inputFields_brokerName_placeholder,
                                          items: AppConstants.custodianList),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_assetType_label,
                                      child: AppTextFields.dropDownTextField(
                                        onChanged: (val) async {
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));

                                          if (securityName?.category == val) {
                                            setState(() {
                                              isDisableCategory = true;
                                            });
                                          } else {
                                            setState(() {
                                              isDisableCategory = false;
                                            });
                                          }

                                          if (val == "FixedIncome") {
                                            setState(() {
                                              isFixedIncome = true;
                                            });
                                          } else {
                                            formKey.currentState
                                                ?.setInternalFieldValue(
                                                    "maturityDate", null,
                                                    isSetState: true);
                                            formKey.currentState
                                                ?.setInternalFieldValue(
                                                    "couponRate", null,
                                                    isSetState: true);
                                            setState(() {
                                              isFixedIncome = false;
                                            });
                                          }
                                          checkFinalValid(val);
                                          print(formKey.currentState!
                                              .instantValue["category"]);
                                        },
                                        enabled: !isDisableCategory,
                                        name: "category",
                                        hint: appLocalizations
                                            .assetLiabilityForms_forms_listedAssets_inputFields_assetType_placeholder,
                                        items: ListedSecurityType
                                            .listedSecurityList
                                            .map((e) => DropdownMenuItem(
                                                  value: e.value,
                                                  child: Text(e.name),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_label,
                                      child: FormBuilderDateTimePicker(
                                        onChanged: (selectedDate) {
                                          checkFinalValid(selectedDate);
                                        },
                                        lastDate: DateTime.now(),
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        name: "investmentDate",
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
                                                .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_country_label,
                                      child: CountriesDropdown(
                                        onChanged: checkFinalValid,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_currency_label,
                                      child: CurrenciesDropdown(
                                        enabled: !isDisableCurrency,
                                        onChanged: (val) {
                                          debugPrint("currency code");
                                          debugPrint(val?.symbol);
                                          debugPrint(
                                              securityName?.currencyCode);

                                          if (securityName?.currencyCode ==
                                              val?.symbol) {
                                            setState(() {
                                              isDisableCurrency = true;
                                            });
                                          } else {
                                            setState(() {
                                              isDisableCurrency = false;
                                            });
                                          }

                                          checkFinalValid(val);
                                        },
                                        showExchange: true,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_value_label,
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          onChanged: (val) {
                                            setState(() {
                                              valuePerUnit = val;
                                            });
                                            calculateCurrentValue();
                                          },
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "marketValue",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_listedAssets_inputFields_value_placeholder),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_listedAssets_inputFields_quantity_label,
                                      child: AppTextFields.simpleTextField(
                                          type: TextFieldType.rate,
                                          onChanged: (val) {
                                            setState(() {
                                              noOfUnits = val;
                                            });
                                            calculateCurrentValue();
                                            checkFinalValid(val);
                                          },
                                          keyboardType: TextInputType.number,
                                          name: "quantity",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_listedAssets_inputFields_quantity_placeholder),
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Total cost"),
                                            const SizedBox(height: 8),
                                            Text(currentDayValue == "--"
                                                ? currentDayValue
                                                : "\$$currentDayValue")
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isFixedIncome)
                                      Column(children: [
                                        EachTextField(
                                          hasInfo: false,
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_listedAssets_inputFields_couponRate_label,
                                          child: AppTextFields.simpleTextField(
                                            extraValidators: [
                                              (val) {
                                                return ((double.tryParse(
                                                                val ?? "0") ??
                                                            0) <=
                                                        100)
                                                    ? null
                                                    : "Ownership can't be greater then 100";
                                              }
                                            ],
                                            type: TextFieldType.rate,
                                            onChanged: checkFinalValid,
                                            name: "couponRate",
                                            hint: "00",
                                            suffixIcon:
                                                AppTextFields.rateSuffixIcon(),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        EachTextField(
                                          hasInfo: false,
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_listedAssets_inputFields_maturityDate_label,
                                          child: FormBuilderDateTimePicker(
                                            onChanged: (selectedDate) {
                                              checkFinalValid(selectedDate);
                                            },
                                            firstDate: DateTime.now(),
                                            inputType: InputType.date,
                                            format: DateFormat("dd/MM/yyyy"),
                                            name: "maturityDate",
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                hintText: appLocalizations
                                                    .assetLiabilityForms_forms_listedAssets_inputFields_acquisitionDate_placeholder),
                                          ),
                                        ),
                                      ]),
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
