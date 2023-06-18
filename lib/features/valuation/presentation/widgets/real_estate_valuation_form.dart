import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/map_utils.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/valuation/data/models/valuation_action_type.dart';

class RealEstateValuationFormWidget extends StatefulWidget {
  final Function buildActions;
  final bool isEdit;
  const RealEstateValuationFormWidget(
      {Key? key, required this.buildActions, required this.isEdit})
      : super(key: key);
  @override
  AppState<RealEstateValuationFormWidget> createState() =>
      _RealEstateValuationFormWidgetState();
}

class _RealEstateValuationFormWidgetState
    extends AppState<RealEstateValuationFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  Map<String, dynamic>? lastValue;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;

  DateTime? aqusitionDateValue;

  bool haveBuy = false;

  String currentDayValue = "--";
  String? noOfUnits = "";
  String? valuePerUnit = "";
  String? ownerShip = "";

  @override
  void didUpdateWidget(covariant RealEstateValuationFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;

    Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
    if (finalValid) {
      if (widget.isEdit == true) {
        if (!compareMaps(instantValue, lastValue!)) {
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
      } else {
        if (!enableAddAssetButton) {
          setState(() {
            enableAddAssetButton = true;
          });
        }
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

    // if (ownerShip == "" || ownerShip == null) {
    //   setState(() {
    //     currentDayValue = defaultValue;
    //   });
    //   return;
    // }

    final noOfUnitsParsed = noOfUnits != null ? double.tryParse(noOfUnits!) : 0;
    final valuePerUnitParsed = valuePerUnit != null
        ? int.tryParse(valuePerUnit.toString().replaceAll(',', ''))
        : 0;
    // final ownerShipParsed = ownerShip != null
    //     ? double.tryParse(ownerShip.toString().replaceAll(',', ''))
    //     : 0;
    const ownerShipParsed = 100;

    setState(() {
      currentDayValue = NumberFormat("#,##0", "en_US").format(
          (noOfUnitsParsed! * valuePerUnitParsed!) * (ownerShipParsed! / 100));
    });
  }

  void setFormValues(Map<String, dynamic> json) {
    // json.removeWhere((key, value) => (value == "" || value == null));

    if (formKey.currentState != null) {
      debugPrint("working inside real estate form setup setFormValues");
      debugPrint(json.toString());

      try {
        formKey.currentState?.patchValue(json);

        setState(() {
          lastValue = lastValue != null ? {...?lastValue, ...json} : json;
        });
      } catch (e) {
        debugPrint("patchValue failed");
        debugPrint(e.toString());
      }

      debugPrint(json["acquisitionDate"].toString());
      debugPrint(json["type"].toString());
      debugPrint(json["isRealEstate"].toString());

      if (json["type"] == 'Buy') {
        setState(() {
          haveBuy = true;
        });
      } else if (json["isRealEstate"] == false) {
        setState(() {
          haveBuy = true;
        });
      }

      setState(() {
        aqusitionDateValue = json["acquisitionDate"];
      });
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Column(children: [
      FormBuilder(
        key: formKey,
        initialValue: widget.isEdit
            ? {}
            : {'note': "New valuation added", "ownershipPercentage": 100},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_date,
              child: FormBuilderDateTimePicker(
                onChanged: (selectedDate) {
                  checkFinalValid(selectedDate);
                  setState(() {
                    availableDateValue = selectedDate;
                  });
                },
                firstDate: aqusitionDateValue,
                lastDate: DateTime.now(),
                inputType: InputType.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: appLocalizations
                          .assets_valuationModal_errors_acquisitionDate)
                ]),
                format: DateFormat("dd/MM/yyyy"),
                name: "valuatedAt",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: appLocalizations
                        .assets_valuationModal_placeholder_date),
              ),
            ),
            EachTextField(
                hasInfo: false,
                title: appLocalizations.assets_valuationModal_labels_action,
                child: RadioButton<String>(
                    errorMsg: appLocalizations.common_errors_required,
                    items: haveBuy
                        ? ValuationActionType.valuationActionTypeList(context)
                        : ValuationActionType.valuationActionTypeListRealEstate(
                            context),
                    name: "type")),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_currency,
              child: CurrenciesDropdown(
                onChanged: checkFinalValid,
                enabled: false,
              ),
            ),
            // EachTextField(
            //   hasInfo: false,
            //   title: appLocalizations.assets_valuationModal_labels_noOfUnits,
            //   child: AppTextFields.simpleTextField(
            //       type: TextFieldType.rate,
            //       errorMsg: appLocalizations.assets_valuationModal_errors_value,
            //       keyboardType: TextInputType.number,
            //       onChanged: (val) {
            //         setState(() {
            //           noOfUnits = val;
            //         });
            //         calculateCurrentValue();
            //         checkFinalValid(val);
            //       },
            //       name: "quantity",
            //       extraValidators: [
            //         (val) {
            //           return ((int.tryParse(val ?? "0") ?? 0) <= 100)
            //               ? null
            //               : "${appLocalizations.assets_valuationModal_labels_noOfUnits} can't be greater then 100";
            //         }
            //       ],
            //       hint: appLocalizations
            //           .assets_valuationModal_placeholder_noOfUnits),
            // ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_valuePerUnit,
              child: AppTextFields.simpleTextField(
                  type: TextFieldType.money,
                  errorMsg: appLocalizations.common_errors_required,
                  onChanged: (val) {
                    setState(() {
                      valuePerUnit = val;
                    });
                    calculateCurrentValue();
                    checkFinalValid(val);
                  },
                  keyboardType: TextInputType.number,
                  name: "pricePerUnit",
                  hint: appLocalizations
                      .assets_valuationModal_placeholder_valuePerUnit),
            ),
            // EachTextField(
            //   hasInfo: false,
            //   title: appLocalizations.assets_valuationModal_labels_ownership,
            //   child: AppTextFields.simpleTextField(
            //       extraValidators: [
            //         (val) {
            //           return ((int.tryParse(val ?? "0") ?? 0) <= 100)
            //               ? null
            //               : appLocalizations
            //                   .assets_valuationModal_errors_ownershipMax;
            //         }
            //       ],
            //       type: TextFieldType.number,
            //       keyboardType: TextInputType.number,
            //       errorMsg: appLocalizations
            //           .assets_valuationModal_errors_ownershipMin,
            //       onChanged: (val) {
            //         setState(() {
            //           ownerShip = val;
            //         });
            //         checkFinalValid(val);

            //         try {
            //           calculateCurrentValue();
            //         } catch (e) {
            //           debugPrint(e.toString());
            //         }
            //       },
            //       name: "ownershipPercentage",
            //       suffixIcon: AppTextFields.rateSuffixIcon(),
            //       hint: appLocalizations
            //           .assets_valuationModal_placeholder_ownership),
            // ),
            if (currentDayValue != "--")
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.anotherCardColorForDarkTheme
                        : AppColors.anotherCardColorForLightTheme,
                    borderRadius: BorderRadius.circular(8)),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLocalizations
                          .assets_valuationModal_labels_totalCost),
                      const SizedBox(height: 8),
                      Text(currentDayValue == "--"
                          ? currentDayValue
                          : "\$$currentDayValue")
                    ],
                  ),
                ),
              ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_note,
              child: AppTextFields.simpleTextField(
                  required: false,
                  onChanged: checkFinalValid,
                  name: "note",
                  hint:
                      appLocalizations.assets_valuationModal_placeholder_note),
            ),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: e,
                  ))
              .toList(),
        ),
      ),
      widget.buildActions(
          formKey, (e) => setFormValues(e), enableAddAssetButton)
    ]);
  }
}
