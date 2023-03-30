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
  const BankValuationFormWidget({Key? key, required this.buildActions})
      : super(key: key);
  @override
  AppState<BankValuationFormWidget> createState() =>
      _BankValuationFormWidgetState();
}

class _BankValuationFormWidgetState extends AppState<BankValuationFormWidget> {
  bool enableAddAssetButton = false;
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

    return Column(
      children: [
        FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  title: appLocalizations
                      .assetLiabilityForms_forms_realEstate_inputFields_currency_label,
                  child: CurrenciesDropdown(
                    onChanged: (e) => checkFinalValid(e),
                    showExchange: false,
                  ),
                ),
                EachTextField(
                  hasInfo: false,
                  title: "Market valuation",
                  child: AppTextFields.simpleTextField(
                      onChanged: (e) => checkFinalValid(e),
                      type: TextFieldType.money,
                      name: "amount",
                      hint: appLocalizations
                          .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_placeholder),
                ),
                EachTextField(
                  hasInfo: false,
                  title: "Note (optional)",
                  child: AppTextFields.simpleTextField(
                      required: false,
                      onChanged: (e) => checkFinalValid(e),
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
            )),
        widget.buildActions(formKey)
        //     BlocProvider(
        // create: (context) => sl<AssetValuationCubit>(),
        // child: Builder(builder: (context) {
        //   return Padding(
        //       padding: EdgeInsets.symmetric(
        //           horizontal: responsiveHelper.bigger16Gap * 5),
        //       child: Row(
        //         children: [
        //           OutlinedButton(
        //             onPressed: () {
        //               // View Asset detail button
        //               context.goNamed(AppRoutes.addAssetsView);
        //             },
        //             style: OutlinedButton.styleFrom(
        //                 minimumSize: const Size(100, 50)),
        //             child: Text(
        //               cancelBtn,
        //             ),
        //           ),
        //           SizedBox(width: responsiveHelper.bigger16Gap),
        //           ElevatedButton(
        //             onPressed: () {
        //               debugPrint("formKey.currentState");
        //               // debugPrint(formKey.currentState!.initialValue.toString());
        //               debugPrint(formStateKey.currentState.toString());
        //               // debugPrint(enableAddAssetButton.toString());
        //               // debugPrint(formKey.currentState!.isValid.toString());

        //               formStateKey.currentState?.validate();
        //               if (formStateKey.currentState!.isValid) {
        //                 Map<String, dynamic> finalMap =
        //                     renderSubmitData(assetType, formStateKey);

        //                 print(finalMap);

        //                 context
        //                     .read<AssetValuationCubit>()
        //                     .postValuation(map: finalMap);
        //               }
        //             },
        //             style: ElevatedButton.styleFrom(
        //                 minimumSize: const Size(100, 50)),
        //             child: Text(confirmBtn),
        //           )
        //         ],
        //       ));
        // }))
      ],
    );
  }
}
