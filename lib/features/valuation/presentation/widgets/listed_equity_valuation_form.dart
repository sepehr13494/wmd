import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/valuation/data/models/valuation_action_type.dart';

class ListedEquityValuationFormWidget extends StatefulWidget {
  const ListedEquityValuationFormWidget({Key? key}) : super(key: key);
  @override
  AppState<ListedEquityValuationFormWidget> createState() =>
      _ListedEquityValuationFormWidgettState();
}

class _ListedEquityValuationFormWidgettState
    extends AppState<ListedEquityValuationFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;

  @override
  void didUpdateWidget(covariant ListedEquityValuationFormWidget oldWidget) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add valuation",
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            EachTextField(
              hasInfo: false,
              title: "Date",
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
                name: "date",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: appLocalizations
                        .scheduleMeeting_availableDate_placeholder),
              ),
            ),
            const EachTextField(
                hasInfo: false,
                title: "Action",
                child: RadioButton<String>(
                    items: ValuationActionType.valuationActionTypeList,
                    name: "action")),
            EachTextField(
              hasInfo: false,
              title: appLocalizations
                  .assetLiabilityForms_forms_realEstate_inputFields_currency_label,
              child: CurrenciesDropdown(
                onChanged: checkFinalValid,
                showExchange: false,
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
                      return ((int.tryParse(val ?? "0") ?? 0) <= 100)
                          ? null
                          : "${appLocalizations.assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_label} can't be greater then 100";
                    }
                  ],
                  hint: appLocalizations
                      .assetLiabilityForms_forms_realEstate_inputFields_numberofUnits_placeholder),
            ),
            EachTextField(
              title: "Cost per unit",
              child: AppTextFields.simpleTextField(
                  required: false,
                  type: TextFieldType.money,
                  keyboardType: TextInputType.number,
                  name: "marketValue",
                  hint: appLocalizations
                      .assetLiabilityForms_forms_realEstate_inputFields_valuePerUnit_placeholder),
            ),
            EachTextField(
              hasInfo: false,
              title: "Note (optional)",
              child: AppTextFields.simpleTextField(
                  onChanged: checkFinalValid,
                  name: "note",
                  hint: appLocalizations
                      .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_placeholder),
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
    ]);
  }
}
