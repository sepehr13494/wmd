import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/map_utils.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';

class BankValuationFormWidget extends StatefulWidget {
  final Function buildActions;
  final bool isEdit;
  const BankValuationFormWidget(
      {Key? key, required this.buildActions, required this.isEdit})
      : super(key: key);
  @override
  AppState<BankValuationFormWidget> createState() =>
      _BankValuationFormWidgetState();
}

class _BankValuationFormWidgetState extends AppState<BankValuationFormWidget> {
  bool enableAddAssetButton = false;
  Map<String, dynamic>? lastValue;
  bool isSavingOrCurrentBank = false;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

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

  void setFormValues(Map<String, dynamic> json) {
    // json.removeWhere((key, value) => (value == "" || value == null));
    debugPrint("working real setup setFormValues");
    if (formKey.currentState != null) {
      debugPrint("working inside real setup setFormValues");
      debugPrint(json.toString());

      if (json['isSavingOrCurrentBank'] == true) {
        setState(() {
          isSavingOrCurrentBank = true;
        });
      }

      formKey.currentState?.patchValue(json);

      setState(() {
        lastValue = lastValue != null ? {...?lastValue, ...json} : json;
      });
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Column(
      children: [
        FormBuilder(
            key: formKey,
            initialValue: widget.isEdit ? {} : {'note': "New Balance added"},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // EachTextField(
                //   hasInfo: false,
                //   title: appLocalizations.assets_valuationModal_labels_date,
                //   child: FormBuilderDateTimePicker(
                //     onChanged: (selectedDate) {
                //       checkFinalValid(selectedDate);
                //       setState(() {
                //         availableDateValue = selectedDate;
                //       });
                //     },
                //     lastDate: DateTime.now(),
                //     inputType: InputType.date,
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     validator: FormBuilderValidators.compose([
                //       FormBuilderValidators.required(
                //           errorText: appLocalizations
                //               .assets_valuationModal_errors_acquisitionDate)
                //     ]),
                //     format: DateFormat("dd/MM/yyyy"),
                //     name: "valuatedAt",
                //     decoration: InputDecoration(
                //         suffixIcon: Icon(
                //           Icons.calendar_month,
                //           color: Theme.of(context).primaryColor,
                //         ),
                //         hintText: appLocalizations
                //             .assets_valuationModal_placeholder_date),
                //   ),
                // ),
                EachTextField(
                  hasInfo: false,
                  title: appLocalizations.assets_valuationModal_labels_currency,
                  child: CurrenciesDropdown(
                    onChanged: (e) => checkFinalValid(e),
                    enabled: false,
                  ),
                ),
                EachTextField(
                  hasInfo: false,
                  title: appLocalizations
                      .assets_valuationModal_labels_currentBalanceValue,
                  child: AppTextFields.simpleTextField(
                      onChanged: (e) => checkFinalValid(e),
                      errorMsg: appLocalizations.common_errors_required,
                      keyboardType: TextInputType.phone,
                      type: isSavingOrCurrentBank
                          ? TextFieldType.minusMoney
                          : TextFieldType.money,
                      name: "pricePerUnit",
                      hint: appLocalizations
                          .assets_valuationModal_placeholder_currentBalanceValue),
                ),
                EachTextField(
                  hasInfo: false,
                  title: appLocalizations.assets_valuationModal_labels_note,
                  child: AppTextFields.simpleTextField(
                      required: false,
                      onChanged: (e) => checkFinalValid(e),
                      name: "note",
                      hint: appLocalizations
                          .assets_valuationModal_placeholder_note),
                ),
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: e,
                      ))
                  .toList(),
            )),
        const SizedBox(
          height: 48,
        ),
        widget.buildActions(
            formKey, (e) => setFormValues(e), enableAddAssetButton)
      ],
    );
  }
}
