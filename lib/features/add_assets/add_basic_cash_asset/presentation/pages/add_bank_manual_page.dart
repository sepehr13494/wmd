import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';

class AddBankManualPage extends StatefulWidget {
  const AddBankManualPage({Key? key}) : super(key: key);

  @override
  AppState<AddBankManualPage> createState() => _AddBankManualPageState();
}

class _AddBankManualPageState extends AppState<AddBankManualPage> {
  final baseFormKey = GlobalKey<FormBuilderState>();
  String? accountType;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final termFormKey = GlobalKey<FormBuilderState>();
    final otherFormKey = GlobalKey<FormBuilderState>();
    late Widget changeItems;
    final isDepositTerm = accountType == "Term deposit";
    if (isDepositTerm) {
      changeItems = FormBuilder(
        key: termFormKey,
        child: Column(
          children: [
            EachTextField(
              title: "Ownership",
              child: AppTextFields.simpleTextField(
                  name: "ownershipPercentage",
                  hint: "50%",
                  keyboardType: TextInputType.number),
            ),
            EachTextField(
              title: "Principal (original deposit amount)",
              child: AppTextFields.simpleTextField(
                  name: "principal", hint: "\$20,000"),
            ),
            EachTextField(
              title: "Rate (optional)",
              child: AppTextFields.simpleTextField(
                  name: "interestRate", hint: "50.00", required: false),
            ),
            EachTextField(
              title: "Start date",
              child: FormBuilderDateTimePicker(
                inputType: InputType.date,
                name: "startDate",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: "02/11/2022"),
              ),
            ),
            EachTextField(
                title: "Tenure",
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: EachTextField(
                          hasInfo: false,
                          title: "Years",
                          child: AppTextFields.simpleTextField(
                              name: "years",
                              hint: "00",
                              keyboardType: TextInputType.number),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EachTextField(
                          hasInfo: false,
                          title: "Months",
                          child: AppTextFields.simpleTextField(
                              name: "months",
                              hint: "00",
                              keyboardType: TextInputType.number),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: EachTextField(
                          hasInfo: false,
                          title: "Days",
                          child: AppTextFields.simpleTextField(
                              name: "days",
                              hint: "00",
                              keyboardType: TextInputType.number),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.anotherCardColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("End term"),
                    const SizedBox(height: 8),
                    Text("10/27/2022")
                  ],
                ),
              ),
            ),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: e,
                  ))
              .toList(),
        ),
      );
    } else {
      changeItems = FormBuilder(
        key: otherFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: EachTextField(
            title: "Current balance",
            child: AppTextFields.simpleTextField(
                name: "currentBalance",
                hint: "\$500,000",
                keyboardType: TextInputType.number),
          ),
        ),
      );
    }
    return BlocProvider(
      create: (context) => sl<BankCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Asset"),
        ),
        bottomSheet: AddAssetFooter(
            buttonText: "Add asset",
            onTap: () {
              late Map<String, dynamic> finalMap;
              if (isDepositTerm) {
                finalMap = {
                  ...baseFormKey.currentState!.instantValue,
                  ...termFormKey.currentState!.instantValue,
                };
              } else {
                finalMap = {
                  ...baseFormKey.currentState!.instantValue,
                  ...otherFormKey.currentState!.instantValue,
                };
              }
              print(finalMap);
              print(finalMap['country'].toString());
              sl<BankCubit>().postBankDetails(map: finalMap);
            }),
        body: Theme(
          data: Theme.of(context).copyWith(),
          child: Stack(
            children: [
              const LeafBackground(),
              WidthLimiterWidget(
                child: BlocConsumer<BankCubit, BankSaveState>(
                  listener: BlocHelper.defaultBlocListener(
                      listener: (context, state) {}),
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(children: [
                        FormBuilder(
                          key: baseFormKey,
                          child: Column(
                            children: [
                              Text(
                                "Add bank account",
                                style: textTheme.headlineSmall,
                              ),
                              Text(
                                "Fill in your cash details",
                                style: textTheme.titleMedium,
                              ),
                              EachTextField(
                                  hasInfo: false,
                                  title: "Bank Name",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormBuilderTypeAhead(
                                          name: "bankName",
                                          hint: "Your bank name",
                                          items: [
                                            "Bank 1",
                                            "Bank 2",
                                            "Bank 3"
                                          ]),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Link your bank account",
                                          style: textTheme.titleSmall!.apply(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  )),
                              EachTextField(
                                hasInfo: false,
                                title: "Description",
                                child: AppTextFields.simpleTextField(
                                    name: "description",
                                    hint:
                                        "A nickname you give to your account"),
                              ),
                              const EachTextField(
                                hasInfo: false,
                                title: "Country",
                                child: CountriesDropdown(),
                              ),
                              EachTextField(
                                title: "Account Type",
                                child: AppTextFields.dropDownTextField(
                                  onChanged: (val) {
                                    setState(() {
                                      accountType = val;
                                    });
                                  },
                                  name: "accountType",
                                  hint: "Type or select account type",
                                  items: [
                                    "Saving account",
                                    "current account",
                                    "Term deposit"
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                ),
                              ),
                              const EachTextField(
                                hasInfo: false,
                                title: "Currency",
                                child: CurrenciesDropdown(),
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
                        changeItems,
                        const SizedBox(height: 60),
                      ]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
