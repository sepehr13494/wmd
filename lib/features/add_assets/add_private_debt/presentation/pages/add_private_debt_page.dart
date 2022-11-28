import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/manager/private_debt_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/injection_container.dart';

class AddPrivateDebtPage extends StatefulWidget {
  const AddPrivateDebtPage({Key? key}) : super(key: key);
  @override
  AppState<AddPrivateDebtPage> createState() => _AddPrivateDebtState();
}

class _AddPrivateDebtState extends AppState<AddPrivateDebtPage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  DateTime? aqusitionDateValue;
  @override
  void didUpdateWidget(covariant AddPrivateDebtPage oldWidget) {
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
    return BlocProvider(
      create: (context) => sl<PrivateDebtCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add private debt",
          ),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: !enableAddAssetButton
                  ? null
                  : () {
                      Map<String, dynamic> finalMap = {
                        ...privateDebtFormKey.currentState!.instantValue,
                      };

                      print(finalMap);

                      context
                          .read<PrivateDebtCubit>()
                          .postPrivateDebt(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<PrivateDebtCubit, PrivateDebtState>(
                        listener: BlocHelper.defaultBlocListener(
                            listener: (context, state) {
                      if (state is PrivateDebtSaved) {
                        context.read<MainDashboardCubit>().initPage();
                        final successValue = state.privateDebtSaveResponse;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SuccessModalWidget(
                              title:
                                  'Private debt is successfully added to wealth overview',
                              confirmBtn: appLocalizations
                                  .common_formSuccessModal_buttons_viewAsset,
                              cancelBtn: appLocalizations
                                  .common_formSuccessModal_buttons_addAsset,
                              aquiredCost:
                                  successValue.startingBalance.convertMoney(),
                              marketPrice: successValue.totalNetWorthChange
                                  .convertMoney(),
                              netWorth:
                                  successValue.totalNetWorth.convertMoney(),
                              netWorthChange: successValue.totalNetWorthChange
                                  .convertMoney(),
                            );
                          },
                        );
                      }
                    }), builder: (context, state) {
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
                                  appLocalizations
                                      .assetLiabilityForms_heading_privateDebt,
                                  style: textTheme.headlineSmall,
                                ),
                                Text(
                                  appLocalizations
                                      .assetLiabilityForms_subHeading_privateDebt,
                                  style: textTheme.bodySmall,
                                ),
                                Text(
                                  "Fill in the private debt details",
                                  style: textTheme.titleSmall,
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Name",
                                  child: AppTextFields.simpleTextField(
                                      title: "Name",
                                      name: "investmentName",
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
                                          "Type the name of your private debt"),
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Custodian (optional)",
                                  child: FormBuilderTypeAhead(
                                      onChange: checkFinalValid,
                                      name: "wealthManager",
                                      hint: "Type the name of custodian",
                                      items: AppConstants.custodianList),
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Country",
                                  child: CountriesDropdown(
                                    onChanged: checkFinalValid,
                                  ),
                                ),
                                EachTextField(
                                  title: "Acquisition date",
                                  child: FormBuilderDateTimePicker(
                                    onChanged: (selectedDate) {
                                      checkFinalValid(selectedDate);
                                      setState(() {
                                        aqusitionDateValue = selectedDate;
                                      });
                                    },
                                    lastDate: DateTime.now(),
                                    inputType: InputType.date,
                                    format: DateFormat("dd/MM/yyyy"),
                                    name: "investmentDate",
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        hintText: "DD/MM/YYYY"),
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
                                  title: "Initial investment amount",
                                  child: AppTextFields.simpleTextField(
                                      onChanged: checkFinalValid,
                                      type: TextFieldType.money,
                                      name: "investmentAmount",
                                      hint: "Book value of initial investment"),
                                ),
                                EachTextField(
                                  title: "Valuation date",
                                  child: FormBuilderDateTimePicker(
                                    firstDate: aqusitionDateValue,
                                    lastDate: DateTime.now(),
                                    format: DateFormat("dd/MM/yyyy"),
                                    inputType: InputType.date,
                                    name: "valuationDate",
                                    onChanged: checkFinalValid,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        hintText: "DD/MM/YYYY"),
                                  ),
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Current value",
                                  child: AppTextFields.simpleTextField(
                                      onChanged: checkFinalValid,
                                      type: TextFieldType.money,
                                      name: "marketValue",
                                      hint:
                                          "The current day value of the asset"),
                                ),
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
