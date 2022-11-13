import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/account_type.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';
import 'package:wmd/core/extentions/num_ext.dart';

class AddBankManualPage extends StatefulWidget {
  const AddBankManualPage({Key? key}) : super(key: key);

  @override
  AppState<AddBankManualPage> createState() => _AddBankManualPageState();
}

class _AddBankManualPageState extends AppState<AddBankManualPage> {
  final baseFormKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> bottomFormKey = GlobalKey<FormBuilderState>();
  String date = "--/--/--";
  String? accountType;

  @override
  void didUpdateWidget(covariant AddBankManualPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  checkFinalValid(val){
    bool finalValid = (
        baseFormKey.currentState!.isValid && bottomFormKey.currentState!.isValid
    );
    if(finalValid){
      print(finalValid);
    }else{
      print(finalValid);
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    late Widget changeItems;
    final isDepositTerm = accountType == "TermDeposit";
    final isSavingAccount = accountType == "SavingAccount";

    if (isDepositTerm) {
      changeItems = FormBuilder(
        key: bottomFormKey,
        child: Column(
          children: [
            EachTextField(
              title: "Ownership",
              child: AppTextFields.simpleTextField(
                  onChanged: checkFinalValid,
                  name: "ownershipPercentage",
                  hint: "50%",
                  keyboardType: TextInputType.number),
            ),
            EachTextField(
              title: "Principal (original deposit amount)",
              child: AppTextFields.simpleTextField(
                onChanged: checkFinalValid,
                name: "principal",
                hint: "\$20,000",
              ),
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
                            onChanged: (val){
                              checkFinalValid(val);
                              changeDate();
                            },
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
                              onChanged: (val){
                                checkFinalValid(val);
                                changeDate();
                              },
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
                              onChanged: (val){
                                checkFinalValid(val);
                                changeDate();
                              },
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
                    Text(date)
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
        key: bottomFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: EachTextField(
                title: "Current balance",
                child: AppTextFields.simpleTextField(
                    name: "currentBalance",
                    hint: "\$500,000",
                    type: TextFieldType.money,
                    onChanged: checkFinalValid,
                    keyboardType: TextInputType.number),
              ),
            ),
            isSavingAccount ? Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: EachTextField(
                title: "Rate (optional)",
                child: AppTextFields.simpleTextField(
                    name: "interestRate",
                    hint: "Enter rate",
                    onChanged: checkFinalValid,
                    extraValidators: [
                      (val){
                        return ((int.tryParse(val??"0")??0) < 100) ? null : "rate can't be greater then 100";
                      }
                    ],
                    keyboardType: TextInputType.number),
              ),
            ) : const SizedBox()
          ],
        ),
      );
    }
    return BlocProvider(
      create: (context) => sl<BankCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add asset",
          ),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: () {
                Map<String, dynamic> finalMap = {
                  ...baseFormKey.currentState!.instantValue,
                  ...bottomFormKey.currentState!.instantValue,
                };
                context.read<BankCubit>().postBankDetails(map: finalMap);
              }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<BankCubit, BankSaveState>(
                      listener: BlocHelper.defaultBlocListener(
                          listener: (context, state) {
                        if (state is BankDetailSaved) {
                          final successValue = state.bankSaveResponse;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SuccessModalWidget(
                                title:
                                    '[Asset] is successfully added to wealth overview',
                                confirmBtn: appLocalizations
                                    .common_formSuccessModal_buttons_viewAsset,
                                cancelBtn: appLocalizations
                                    .common_formSuccessModal_buttons_addAsset,
                                aquiredCost:
                                    successValue.startingBalance.toMoney(),
                                marketPrice:
                                    successValue.totalNetWorthChange.toMoney(),
                                netWorth: successValue.totalNetWorth.toMoney(),
                                netWorthChange:
                                    successValue.totalNetWorthChange.toMoney(),
                              );
                            },
                          ).then((isConfirm) {
                            if (isConfirm != null && isConfirm == true) {
                              // View Asset detail button
                              GoRouter.of(context).goNamed(AppRoutes.dashboard);
                              // context.goNamed(AppRoutes.dashboard);
                            } else if (isConfirm != null &&
                                isConfirm == false) {
                              // add another asset button
                              GoRouter.of(context)
                                  .goNamed(AppRoutes.addAssetsView);
                              // context.goNamed(AppRoutes.dashboard);
                            }
                          });
                        }
                      }),
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Column(children: [
                            FormBuilder(
                              key: baseFormKey,
                              initialValue:
                                  AddAssetConstants.initialJsonForAddAsset,
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
                                              style: textTheme.titleSmall!
                                                  .apply(
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
                                        print(val);
                                        setState(() {
                                          bottomFormKey = GlobalKey<FormBuilderState>();
                                          accountType = val;
                                        });
                                      },
                                      name: "accountType",
                                      hint: "Type or select account type",
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
    final map = bottomFormKey.currentState!.instantValue;
    final int year = int.tryParse(map["year"]??"0")??0;
    final int month = int.tryParse(map["month"]??"0")??0;
    final int day = int.tryParse(map["day"]??"0")??0;
    setState(() {
      var startDate = map["startDate"];
      startDate = DateTime(startDate.year,startDate.month,startDate.day + day);
      startDate = DateTime(startDate.year,startDate.month + month,startDate.day);
      startDate = DateTime(startDate.year + year,startDate.month,startDate.day);
      date = "${startDate.day}/${startDate.month}/${startDate.year}";
    });
  }
}
