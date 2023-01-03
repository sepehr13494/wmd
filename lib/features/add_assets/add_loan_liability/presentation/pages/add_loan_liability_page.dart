import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/models/radio_type.dart';
import 'package:wmd/features/add_assets/add_loan_liability/presentation/manager/loan_liability_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/loan_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/injection_container.dart';

class AddLoanLiabilityPage extends StatefulWidget {
  const AddLoanLiabilityPage({Key? key}) : super(key: key);
  @override
  AppState<AddLoanLiabilityPage> createState() => _AddLoanLiabilityState();
}

class _AddLoanLiabilityState extends AppState<AddLoanLiabilityPage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool isPersonalLoan = false;
  DateTime? aqusitionDateValue;
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
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add Real Estate",
          ),
          bottomSheet: AddAssetFooter(
              buttonText: "Add liability",
              onTap: !enableAddAssetButton
                  ? null
                  : () {
                      Map<String, dynamic> finalMap = {
                        ...privateDebtFormKey.currentState!.instantValue,
                      };

                      print(finalMap);

                      context
                          .read<LoanLiabilityCubit>()
                          .postLoanLiability(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<LoanLiabilityCubit, LoanLiabilityState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {}, asset: "Loan"),
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
                                      "Add loan details",
                                      style: textTheme.headlineSmall,
                                    ),
                                    Text(
                                      "Mortgage, personal loan, vehicle loan etc.",
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Fill in your liability details",
                                      style: textTheme.titleSmall,
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Name",
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
                                          hint:
                                              "A nickname you give to your loan"),
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
                                            title: "Bank name (optional)",
                                            child: FormBuilderTypeAhead(
                                                name: "bankName",
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
                                                hint: "Your bank name",
                                                items: state));
                                      },
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Type",
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
                                        hint: "Type or select the loan type",
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
                                      title: "Currency",
                                      child: CurrenciesDropdown(
                                        onChanged: checkFinalValid,
                                        showExchange: true,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Loan amount - outstanding",
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          onChanged: checkFinalValid,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "loanAmountOutstanding",
                                          hint: "Type loan amount"),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title:
                                          "Loan amount - sanctioned (optional)",
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "loanAmountSanctioned",
                                          hint: "Type sanctioned loan amount"),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Start date (optional)",
                                      child: FormBuilderDateTimePicker(
                                        onChanged: (selectedDate) {
                                          setState(() {
                                            aqusitionDateValue = selectedDate;
                                          });
                                        },
                                        lastDate: DateTime.now(),
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        name: "startDate",
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: "DD/MM/YYYY"),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "End date (optional)",
                                      child: FormBuilderDateTimePicker(
                                        firstDate: aqusitionDateValue,
                                        lastDate: DateTime.now(),
                                        format: DateFormat("dd/MM/yyyy"),
                                        inputType: InputType.date,
                                        name: "endDate",
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: "DD/MM/YYYY"),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Rate (optional)",
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
                                          hint: "Type in a figure"),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Monathly payment (optional)",
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "monthlyPayment",
                                          hint: "Type monthly payment"),
                                    ),
                                    if (!isPersonalLoan)
                                      const EachTextField(
                                          hasInfo: false,
                                          title: "Collateral (optional)",
                                          child: RadioButton<bool>(
                                              items: RadioLiabilityType
                                                  .radioLiabilityList,
                                              name: "collateral")),
                                    const EachTextField(
                                        hasInfo: false,
                                        title: "Insurance (optional)",
                                        child: RadioButton<bool>(
                                            items: RadioLiabilityType
                                                .radioLiabilityList,
                                            name: "insurance")),
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
