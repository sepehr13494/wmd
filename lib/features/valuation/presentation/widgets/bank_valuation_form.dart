import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/valuation/data/models/valuation_action_type.dart';
import 'package:wmd/features/valuation/presentation/manager/valuation_cubit.dart';
import 'package:wmd/injection_container.dart';

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
  late Map<String, dynamic> lastValue;
  bool hasTimeLineSelected = false;
  DateTime? availableDateValue;
  FormBuilderState? formState;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    setState(() {
      formState = formKey.currentState;
    });
    Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
    if (finalValid) {
      if (widget.isEdit == true) {
        if (lastValue.toString() != instantValue.toString()) {
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
    formState?.save();
  }

  void setFormValues(Map<String, dynamic> json) {
    json.removeWhere((key, value) => (value == "" || value == null));
    debugPrint("working real setup setFormValues");
    if (formKey.currentState != null) {
      debugPrint("working inside real setup setFormValues");
      debugPrint(json.toString());
      formKey.currentState?.patchValue(json);
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
            initialValue: widget.isEdit ? {} : {'note': "New valuation added"},
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
                  title: appLocalizations.assets_valuationModal_labels_currency,
                  child: CurrenciesDropdown(
                    onChanged: (e) => checkFinalValid(e),
                    showExchange: false,
                    enabled: false,
                  ),
                ),
                EachTextField(
                  hasInfo: false,
                  title: appLocalizations
                      .assets_valuationModal_labels_marketValuation,
                  child: AppTextFields.simpleTextField(
                      onChanged: (e) => checkFinalValid(e),
                      errorMsg: appLocalizations.common_errors_required,
                      type: TextFieldType.money,
                      name: "pricePerUnit",
                      hint: appLocalizations
                          .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_placeholder),
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
        widget.buildActions(formKey, (e) => setFormValues(e))
      ],
    );
  }
}
