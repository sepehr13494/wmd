import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/valuation/data/models/valuation_action_type.dart';

class RealEstateValuationFormWidget extends StatefulWidget {
  final Function buildActions;
  const RealEstateValuationFormWidget({Key? key, required this.buildActions})
      : super(key: key);
  @override
  AppState<RealEstateValuationFormWidget> createState() =>
      _RealEstateValuationFormWidgetState();
}

class _RealEstateValuationFormWidgetState
    extends AppState<RealEstateValuationFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;

  String currentDayValue = "--";
  String? noOfUnits = "";
  String? valuePerUnit = "";

  @override
  void didUpdateWidget(covariant RealEstateValuationFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    setState(() {
      formState = formKey.currentState;
    });

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
    formState?.save();
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
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Column(children: [
      FormBuilder(
        key: formKey,
        // initialValue: {
        //   "type": "Virtual Meeting",
        //   "email": (personalState is PersonalInformationLoaded)
        //       ? personalState.getNameEntity.email
        //       : ""
        // },
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
                lastDate: DateTime.now(),
                inputType: InputType.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                format: DateFormat("dd/MM/yyyy"),
                name: "valuatedAt",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: appLocalizations
                        .scheduleMeeting_availableDate_placeholder),
              ),
            ),
            EachTextField(
                hasInfo: false,
                title: appLocalizations.assets_valuationModal_labels_action,
                child: RadioButton<String>(
                    items: ValuationActionType.valuationActionTypeList(context),
                    name: "type")),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_currency,
              child: CurrenciesDropdown(
                onChanged: checkFinalValid,
                showExchange: false,
              ),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_noOfUnits,
              child: AppTextFields.simpleTextField(
                  type: TextFieldType.rate,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      noOfUnits = val;
                    });
                    calculateCurrentValue();
                    checkFinalValid(val);
                  },
                  name: "quantity",
                  extraValidators: [
                    (val) {
                      return ((int.tryParse(val ?? "0") ?? 0) <= 100)
                          ? null
                          : "${appLocalizations.assets_valuationModal_labels_noOfUnits} can't be greater then 100";
                    }
                  ],
                  hint: appLocalizations
                      .assets_valuationModal_placeholder_noOfUnits),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_valuePerUnit,
              child: AppTextFields.simpleTextField(
                  required: false,
                  type: TextFieldType.money,
                  onChanged: (val) {
                    setState(() {
                      valuePerUnit = val;
                    });
                    calculateCurrentValue();
                  },
                  keyboardType: TextInputType.number,
                  name: "amount",
                  hint: appLocalizations
                      .assets_valuationModal_placeholder_valuePerUnit),
            ),
            EachTextField(
              hasInfo: false,
              title: appLocalizations.assets_valuationModal_labels_ownership,
              child: AppTextFields.simpleTextField(
                  extraValidators: [
                    (val) {
                      return ((int.tryParse(val ?? "0") ?? 0) <= 100)
                          ? null
                          : appLocalizations
                              .assets_valuationModal_errors_ownershipMax;
                    }
                  ],
                  type: TextFieldType.number,
                  keyboardType: TextInputType.number,
                  onChanged: checkFinalValid,
                  name: "ownershipPercentage",
                  hint: appLocalizations
                      .assets_valuationModal_placeholder_ownership),
            ),
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
                    const Text("Total cost"),
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
      widget.buildActions(formKey)
    ]);
  }
}