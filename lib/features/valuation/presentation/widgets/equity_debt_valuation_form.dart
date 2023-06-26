import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_form_builder_date_picker.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/map_utils.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/valuation/data/models/valuation_action_type.dart';

class EquityDebtValuationFormWidget extends StatefulWidget {
  final Function buildActions;
  final bool isEdit;
  const EquityDebtValuationFormWidget(
      {Key? key, required this.buildActions, required this.isEdit})
      : super(key: key);
  @override
  AppState<EquityDebtValuationFormWidget> createState() =>
      _EquityDebtValuationFormWidgetState();
}

class _EquityDebtValuationFormWidgetState
    extends AppState<EquityDebtValuationFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  Map<String, dynamic>? lastValue;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;

  @override
  void didUpdateWidget(covariant EquityDebtValuationFormWidget oldWidget) {
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

  void setFormValues(Map<String, dynamic> json) {
    // json.removeWhere((key, value) => (value == "" || value == null));
    debugPrint("working real setup setFormValues");
    if (formKey.currentState != null) {
      debugPrint("working inside real setup setFormValues");
      debugPrint(json.toString());
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

    return Column(children: [
      FormBuilder(
        key: formKey,
        initialValue: widget.isEdit ? {} : {'note': "New valuation added"},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_date,
              child: AppFormBuilderDateTimePicker(
                onChanged: (selectedDate) {
                  checkFinalValid(selectedDate);
                  setState(() {
                    availableDateValue = selectedDate;
                  });
                },
                lastDate: DateTime.now(),
                inputType: InputType.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
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
                    items: ValuationActionType.jsonInvestment(context),
                    name: "type")),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_currency,
              child: CurrenciesDropdown(
                onChanged: checkFinalValid,
                enabled: false,
              ),
            ),
            EachTextField(
              hasInfo: false,
              title: "Value",
              child: AppTextFields.simpleTextField(
                onChanged: checkFinalValid,
                type: TextFieldType.money,
                name: "pricePerUnit",
                hint: "Value",
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
