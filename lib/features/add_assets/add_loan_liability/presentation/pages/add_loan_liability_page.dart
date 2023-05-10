import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/models/radio_type.dart';
import 'package:wmd/features/add_assets/add_loan_liability/presentation/manager/loan_liability_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/loan_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';
import 'package:wmd/core/extentions/string_ext.dart';

class AddLoanLiabilityPage extends StatefulWidget {
  const AddLoanLiabilityPage({Key? key}) : super(key: key);
  @override
  AppState<AddLoanLiabilityPage> createState() => _AddLoanLiabilityState();
}

class _AddLoanLiabilityState extends AppState<AddLoanLiabilityPage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool isPersonalLoan = false;
  String? outStandingBalance;
  DateTime? aqusitionDateValue;
  DateTime? endDateValue;
  @override
  void didUpdateWidget(covariant AddLoanLiabilityPage oldWidget) {
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

  int getDateDiff(DateTime? start, DateTime end, type) {
    int daysOfYear = 360;
    int daysOfMonth = 29;
    int totalDays = end.difference(start ?? DateTime.now()).inDays;
    int years = totalDays ~/ daysOfYear;
    // final int month = end.month < 12 ? end.month + 1 : 1;
    // int mountOfDay = DateTime(end.year, month, 0).day;
    if (type == 'y') {
      return years;
    } else {
      return (totalDays - years * daysOfYear) ~/ daysOfMonth;
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LoanLiabilityCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BankListCubit>()..getBankList(""),
        ),
      ],
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return handleAssetBackButton(context);
          },
          child: Scaffold(
            appBar: const AddAssetHeader(title: "", showExitModal: true),
            bottomSheet: AddAssetFooter(
                buttonText: "Add liability",
                onTap: () {
                  privateDebtFormKey.currentState?.validate();
                  if (enableAddAssetButton) {
                    Map<String, dynamic> finalMap = {
                      ...privateDebtFormKey.currentState!.instantValue,
                    };
                    context
                        .read<LoanLiabilityCubit>()
                        .postLoanLiability(map: finalMap);
                  }
                }),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Stack(
                children: [
                  const LeafBackground(),
                  WidthLimiterWidget(
                    child: Builder(builder: (context) {
                      return BlocConsumer<LoanLiabilityCubit,
                              LoanLiabilityState>(
                          listener: AssetBlocHelper.defaultBlocListener(
                              listener: (context, state) {},
                              asset: "Loan",
                              assetType: "LoanLiability"),
                          builder: (context, state) {
                            return SingleChildScrollView(
                              child: Column(children: [
                                FormBuilder(
                                  key: privateDebtFormKey,
                                  initialValue:
                                      AddAssetConstants.initialJsonForAddAsset,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appLocalizations
                                            .assetLiabilityForms_heading_loan,
                                        style: textTheme.headlineSmall,
                                      ),
                                      Text(
                                        appLocalizations
                                            .assetLiabilityForms_subHeading_loan,
                                        style: textTheme.bodySmall,
                                      ),
                                      Text(
                                        appLocalizations
                                            .assetLiabilityForms_forms_loan_title,
                                        style: textTheme.titleSmall,
                                      ),
                                      EachTextField(
                                        hasInfo: false,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_name_label,
                                        child: AppTextFields.simpleTextField(
                                            title: "Name",
                                            name: "loanName",
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
                                                .assetLiabilityForms_forms_loan_inputFields_name_placeholder),
                                      ),
                                      BlocSelector<BankListCubit, BankListState,
                                          List<String>>(
                                        selector: (state) =>
                                            state is BankListSuccess
                                                ? state.banks.isEmpty
                                                    ? ["No bank found"]
                                                    : state.banks
                                                        .map((e) => e.name)
                                                        .toList()
                                                : ["No bank found"],
                                        builder: (context, state) {
                                          return EachTextField(
                                              hasInfo: false,
                                              title: appLocalizations
                                                  .assetLiabilityForms_forms_loan_inputFields_bankName_label,
                                              child: FormBuilderTypeAhead(
                                                  name: "bankName",
                                                  required: false,
                                                  onChange: (e) {
                                                    if (e != null) {
                                                      context
                                                          .read<BankListCubit>()
                                                          .getBankList(e);
                                                    }
                                                  },
                                                  prefixIcon: const Icon(
                                                    Icons.search,
                                                  ),
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_loan_inputFields_bankName_placeholder,
                                                  items: state));
                                        },
                                      ),
                                      EachTextField(
                                        hasInfo: false,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_type_label,
                                        child: AppTextFields.dropDownTextField(
                                          onChanged: (e) {
                                            if (e == "Personal") {
                                              setState(() {
                                                isPersonalLoan = true;
                                              });
                                            } else {
                                              setState(() {
                                                isPersonalLoan = false;
                                              });
                                            }

                                            checkFinalValid(e);
                                          },
                                          name: "loanType",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_loan_inputFields_type_placeholder,
                                          items: LoanType.loanList
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
                                            .assetLiabilityForms_forms_loan_inputFields_currency_label,
                                        child: CurrenciesDropdown(
                                          onChanged: checkFinalValid,
                                          showExchange: true,
                                        ),
                                      ),
                                      EachTextField(
                                        hasInfo: true,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_loanAmount_label,
                                        child: AppTextFields.simpleTextField(
                                            onChanged: (val) {
                                              checkFinalValid(val);
                                              setState(() {
                                                outStandingBalance = val;
                                              });
                                            },
                                            type: TextFieldType.money,
                                            keyboardType: TextInputType.number,
                                            name: "loanAmountOutstanding",
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_loan_inputFields_loanAmount_placeholder),
                                      ),
                                      EachTextField(
                                        hasInfo: true,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_loanAmountSanctioned_label,
                                        child: AppTextFields.simpleTextField(
                                            required: false,
                                            type: TextFieldType.money,
                                            keyboardType: TextInputType.number,
                                            name: "loanAmountSanctioned",
                                            extraValidators: [
                                              (val) {
                                                return (val != null &&
                                                        val.convertMoneyToInt() <
                                                            (outStandingBalance
                                                                    ?.convertMoneyToInt() ??
                                                                0))
                                                    ? appLocalizations
                                                        .assetLiabilityForms_forms_loan_inputFields_loanAmountSanctioned_errorMessage
                                                    : null;
                                              }
                                            ],
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_loan_inputFields_loanAmountSanctioned_placeholder),
                                      ),
                                      EachTextField(
                                        hasInfo: true,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_startDate_label,
                                        child: FormBuilderDateTimePicker(
                                          onChanged: (selectedDate) {
                                            setState(() {
                                              aqusitionDateValue = selectedDate;
                                            });
                                          },
                                          initialDate:
                                              endDateValue ?? DateTime.now(),
                                          lastDate:
                                              endDateValue ?? DateTime.now(),
                                          inputType: InputType.date,
                                          format: DateFormat("dd/MM/yyyy"),
                                          name: "startDate",
                                          decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              hintText: appLocalizations
                                                  .assetLiabilityForms_forms_loan_inputFields_startDate_placeholder),
                                        ),
                                      ),
                                      EachTextField(
                                        hasInfo: true,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_endDate_label,
                                        child: FormBuilderDateTimePicker(
                                          firstDate: aqusitionDateValue,
                                          format: DateFormat("dd/MM/yyyy"),
                                          inputType: InputType.date,
                                          name: "endDate",
                                          onChanged: (selectedDate) {
                                            setState(() {
                                              endDateValue = selectedDate;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              hintText: appLocalizations
                                                  .assetLiabilityForms_forms_loan_inputFields_endDate_placeholder),
                                        ),
                                      ),
                                      (endDateValue != null &&
                                              aqusitionDateValue != null)
                                          ? Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? AppColors
                                                          .anotherCardColorForDarkTheme
                                                      : AppColors
                                                          .anotherCardColorForLightTheme,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(appLocalizations
                                                        .assetLiabilityForms_labels_endTermIn),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                        "${getDateDiff(aqusitionDateValue, endDateValue!, 'y')} years ${getDateDiff(aqusitionDateValue, endDateValue!, 'm')} months")
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 0,
                                            ),
                                      EachTextField(
                                        hasInfo: false,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_rate_label,
                                        child: AppTextFields.simpleTextField(
                                            extraValidators: [
                                              (val) {
                                                return ((int.tryParse(
                                                                val ?? "0") ??
                                                            0) <=
                                                        100)
                                                    ? null
                                                    : "Rate can't be greater then 100";
                                              }
                                            ],
                                            type: TextFieldType.number,
                                            required: false,
                                            keyboardType: TextInputType.number,
                                            onChanged: checkFinalValid,
                                            name: "rate",
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_loan_inputFields_rate_placeholder),
                                      ),
                                      EachTextField(
                                        hasInfo: true,
                                        title: appLocalizations
                                            .assetLiabilityForms_forms_loan_inputFields_monthlyPayment_label,
                                        child: AppTextFields.simpleTextField(
                                            required: false,
                                            type: TextFieldType.money,
                                            keyboardType: TextInputType.number,
                                            name: "monthlyPayment",
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_loan_inputFields_monthlyPayment_placeholder),
                                      ),
                                      if (!isPersonalLoan)
                                        EachTextField(
                                            hasInfo: false,
                                            title: appLocalizations
                                                .assetLiabilityForms_forms_loan_inputFields_collateral_label,
                                            child: const RadioButton<bool>(
                                                items: RadioLiabilityType
                                                    .radioLiabilityList,
                                                required: false,
                                                name: "collateral")),
                                      EachTextField(
                                          hasInfo: false,
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_loan_inputFields_insurance_label,
                                          child: const RadioButton<bool>(
                                              items: RadioLiabilityType
                                                  .radioLiabilityList,
                                              required: false,
                                              name: "insurance")),
                                      const SizedBox(height: 60),
                                    ]
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
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
          ),
        );
      }),
    );
  }
}
