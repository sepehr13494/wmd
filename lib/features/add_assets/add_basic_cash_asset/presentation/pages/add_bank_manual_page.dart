import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/account_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';
import 'package:wmd/core/extentions/string_ext.dart';

class AddBankManualPage extends StatefulWidget {
  const AddBankManualPage({Key? key}) : super(key: key);

  @override
  AppState<AddBankManualPage> createState() => _AddBankManualPageState();
}

class _AddBankManualPageState extends AppState<AddBankManualPage> {
  final baseFormKey = GlobalKey<FormBuilderState>();
  // GlobalKey<FormBuilderState> bottomFormKey = GlobalKey<FormBuilderState>();
  String date = "--/--/--";
  String? accountType;
  String endDateToParse = "";
  bool enableAddAssetButton = false;

  @override
  void didUpdateWidget(covariant AddBankManualPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = (baseFormKey.currentState!.isValid);

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
    final isDepositTerm = accountType == "TermDeposit";
    final isSavingAccount = accountType == "SavingAccount";

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BankCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<BankListCubit>()..getBankList(""),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(title: "", showExitModal: true),
          bottomSheet: AddAssetFooter(
            buttonText: "Add asset",
            onTap: () {
              baseFormKey.currentState?.validate();
              if (enableAddAssetButton) {
                Map<String, dynamic> finalMap = {
                  ...baseFormKey.currentState!.instantValue,
                };

                if (isDepositTerm && endDateToParse.isDate()) {
                  finalMap["endDate"] = endDateToParse;
                }
                context.read<BankCubit>().postBankDetails(map: finalMap);
              }
            },
          ),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<BankCubit, BankSaveState>(
                      listener: AssetBlocHelper.defaultBlocListener(
                          listener: (context, state) {},
                          asset: "Bank account",
                          assetType: AssetTypes.bankAccount),
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Column(children: [
                            FormBuilder(
                              key: baseFormKey,
                              initialValue:
                                  AddAssetConstants.initialJsonForAddAsset,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appLocalizations
                                        .assetLiabilityForms_heading_bankAccount,
                                    style: textTheme.headlineSmall,
                                  ),
                                  Text(
                                    appLocalizations
                                        .assetLiabilityForms_subHeading_bankAccount,
                                    style: textTheme.bodySmall,
                                  ),
                                  Text(
                                    appLocalizations
                                        .assetLiabilityForms_forms_bankAccount_title,
                                    style: textTheme.titleSmall,
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
                                              .assetLiabilityForms_forms_bankAccount_inputFields_bankName_label,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FormBuilderTypeAhead(
                                                  extraValidators: [
                                                    (val) {
                                                      return (val != null &&
                                                              val.length > 100)
                                                          ? "BankName must be at most 100 characters"
                                                          : null;
                                                    }
                                                  ],
                                                  name: "bankName",
                                                  onChange: (e) {
                                                    // debugPrint(e);
                                                    if (e != null) {
                                                      context
                                                          .read<BankListCubit>()
                                                          .getBankList(e);

                                                      checkFinalValid(e);
                                                    }
                                                  },
                                                  prefixIcon: const Icon(
                                                    Icons.search,
                                                  ),
                                                  hint: appLocalizations
                                                      .assetLiabilityForms_forms_bankAccount_inputFields_bankName_placeholder,
                                                  items: state),
                                              TextButton(
                                                onPressed: () {
                                                  context.goNamed(
                                                      AppRoutes.autoManualPage);
                                                },
                                                child: Text(
                                                  appLocalizations
                                                      .linkAccount_automaticLink_title,
                                                  style: textTheme.titleSmall!
                                                      .apply(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                  EachTextField(
                                    hasInfo: false,
                                    title: appLocalizations
                                        .assetLiabilityForms_forms_bankAccount_inputFields_description_label,
                                    child: AppTextFields.simpleTextField(
                                        extraValidators: [
                                          (val) {
                                            return ((val?.length ?? 0) > 100
                                                ? "Description must be at most 100 characters"
                                                : null);
                                          }
                                        ],
                                        name: "description",
                                        hint: appLocalizations
                                            .assetLiabilityForms_forms_bankAccount_inputFields_description_placeholder),
                                  ),
                                  EachTextField(
                                    hasInfo: false,
                                    title: appLocalizations
                                        .assetLiabilityForms_forms_bankAccount_inputFields_country_label,
                                    child: CountriesDropdown(
                                      onChanged: checkFinalValid,
                                    ),
                                  ),
                                  EachTextField(
                                    title: appLocalizations
                                        .assetLiabilityForms_forms_bankAccount_inputFields_accountType_label,
                                    child: AppTextFields.dropDownTextField(
                                      onChanged: (val) async {
                                        setState(() {
                                          accountType = val;
                                        });
                                        await Future.delayed(
                                            const Duration(milliseconds: 200));
                                        checkFinalValid(val);
                                      },
                                      name: "accountType",
                                      hint: appLocalizations
                                          .assetLiabilityForms_forms_bankAccount_inputFields_accountType_placeholder,
                                      items: AccountType.accountList
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
                                        .assetLiabilityForms_forms_bankAccount_inputFields_currency_label,
                                    child: CurrenciesDropdown(
                                      onChanged: checkFinalValid,
                                    ),
                                  ),
                                  if (!isDepositTerm)
                                    Column(
                                      children: [
                                        EachTextField(
                                          hasInfo: false,
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_bankAccount_inputFields_balance_label,
                                          child: AppTextFields.simpleTextField(
                                              name: "currentBalance",
                                              hint: appLocalizations
                                                  .assetLiabilityForms_forms_bankAccount_inputFields_balance_placeholder,
                                              type: TextFieldType.money,
                                              onChanged: checkFinalValid,
                                              keyboardType:
                                                  TextInputType.number),
                                        ),
                                        isSavingAccount
                                            ? EachTextField(
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_rate_label,
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        name: "interestRate",
                                                        suffixIcon: AppTextFields
                                                            .rateSuffixIcon(),
                                                        type:
                                                            TextFieldType.rate,
                                                        required: false,
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_bankAccount_inputFields_rate_placeholder,
                                                        onChanged:
                                                            checkFinalValid,
                                                        extraValidators: [
                                                          (val) {
                                                            return ((int.tryParse(val ??
                                                                            "0") ??
                                                                        0) <
                                                                    100)
                                                                ? (int.tryParse(val ??
                                                                                "0") ??
                                                                            0) <
                                                                        0
                                                                    ? "Rate cannot be negative"
                                                                    : null
                                                                : "Rate can't be greater then 100";
                                                          }
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  if (isDepositTerm)
                                    Column(
                                      children: [
                                        EachTextField(
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_bankAccount_inputFields_ownership_label,
                                          child: AppTextFields.simpleTextField(
                                              extraValidators: [
                                                (val) {
                                                  return ((int.tryParse(
                                                                  val ?? "0") ??
                                                              0) <=
                                                          100)
                                                      ? null
                                                      : "Ownership can't be greater then 100";
                                                }
                                              ],
                                              onChanged: checkFinalValid,
                                              name: "ownershipPercentage",
                                              hint: appLocalizations
                                                  .assetLiabilityForms_forms_bankAccount_inputFields_ownership_placeholder,
                                              type: TextFieldType.rate,
                                              suffixIcon: AppTextFields
                                                  .rateSuffixIcon(),
                                              keyboardType:
                                                  TextInputType.number),
                                        ),
                                        EachTextField(
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_bankAccount_inputFields_principal_label,
                                          child: AppTextFields.simpleTextField(
                                            type: TextFieldType.money,
                                            onChanged: checkFinalValid,
                                            name: "currentBalance",
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_bankAccount_inputFields_principal_placeholder,
                                          ),
                                        ),
                                        EachTextField(
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_bankAccount_inputFields_rate_label,
                                          child: AppTextFields.simpleTextField(
                                            extraValidators: [
                                              (val) {
                                                return ((int.tryParse(
                                                                val ?? "0") ??
                                                            0) <=
                                                        100)
                                                    ? (int.tryParse(val ??
                                                                    "0") ??
                                                                0) <
                                                            0
                                                        ? "Rate cannot be negative"
                                                        : null
                                                    : "Rate can't be greater then 100";
                                              }
                                            ],
                                            name: "interestRate",
                                            hint: appLocalizations
                                                .assetLiabilityForms_forms_bankAccount_inputFields_rate_placeholder,
                                            type: TextFieldType.rate,
                                            suffixIcon:
                                                AppTextFields.rateSuffixIcon(),
                                            required: false,
                                          ),
                                        ),
                                        EachTextField(
                                          title: appLocalizations
                                              .assetLiabilityForms_forms_bankAccount_inputFields_startDate_label,
                                          child: FormBuilderDateTimePicker(
                                            validator: FormBuilderValidators
                                                .required(),
                                            name: "startDate",
                                            lastDate: DateTime.now(),
                                            inputType: InputType.date,
                                            format: DateFormat("dd/MM/yyyy"),
                                            onChanged: checkFinalValid,
                                            decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                hintText: appLocalizations
                                                    .assetLiabilityForms_forms_bankAccount_inputFields_startDate_placeholder),
                                          ),
                                        ),
                                        EachTextField(
                                            title: appLocalizations
                                                .assetLiabilityForms_forms_bankAccount_inputFields_tenure_label,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: EachTextField(
                                                      hasInfo: false,
                                                      title: "Years",
                                                      child: AppTextFields
                                                          .simpleTextField(
                                                              required: false,
                                                              onChanged: (val) {
                                                                checkFinalValid(
                                                                    val);
                                                                changeDate();
                                                              },
                                                              name: "years",
                                                              hint: appLocalizations
                                                                  .assetLiabilityForms_forms_bankAccount_inputFields_tenureYears_placeholder,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: EachTextField(
                                                      hasInfo: false,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_tenureMonths_label,
                                                      child: AppTextFields
                                                          .simpleTextField(
                                                              name: "months",
                                                              extraValidators: [
                                                                (val) {
                                                                  return ((int.tryParse(val ?? "0") ??
                                                                              0) <
                                                                          13)
                                                                      ? null
                                                                      : "< 12";
                                                                }
                                                              ],
                                                              onChanged: (val) {
                                                                checkFinalValid(
                                                                    val);
                                                                changeDate();
                                                              },
                                                              hint: appLocalizations
                                                                  .assetLiabilityForms_forms_bankAccount_inputFields_tenureMonths_placeholder,
                                                              required: false,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: EachTextField(
                                                      hasInfo: false,
                                                      title: appLocalizations
                                                          .assetLiabilityForms_forms_bankAccount_inputFields_tenureDays_label,
                                                      child: AppTextFields
                                                          .simpleTextField(
                                                              required: false,
                                                              extraValidators: [
                                                                (val) {
                                                                  return ((int.tryParse(val ?? "0") ??
                                                                              0) <
                                                                          32)
                                                                      ? null
                                                                      : "< 31";
                                                                }
                                                              ],
                                                              onChanged: (val) {
                                                                checkFinalValid(
                                                                    val);
                                                                changeDate();
                                                              },
                                                              name: "days",
                                                              hint: appLocalizations
                                                                  .assetLiabilityForms_forms_bankAccount_inputFields_tenureDays_placeholder,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Container(
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
                                                const Text("End term"),
                                                const SizedBox(height: 8),
                                                Text(date)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 0),
                                                child: e,
                                              ))
                                          .toList(),
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
                            const SizedBox(height: 60),
                          ]),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void changeDate() {
    final map = baseFormKey.currentState!.instantValue;
    var startDate = map["startDate"];
    if (startDate != null) {
      final int year = int.tryParse(map["years"] ?? "0") ?? 0;
      final int month = int.tryParse(map["months"] ?? "0") ?? 0;
      final int day = int.tryParse(map["days"] ?? "0") ?? 0;

      setState(() {
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day + day);
        startDate =
            DateTime(startDate.year, startDate.month + month, startDate.day);
        startDate =
            DateTime(startDate.year + year, startDate.month, startDate.day);
        date = "${startDate.day}/${startDate.month}/${startDate.year}";
        endDateToParse =
            "${startDate.year}-${startDate.month}-${startDate.day}";
      });
    }
  }
}
