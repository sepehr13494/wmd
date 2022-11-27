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
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/manager/other_asset_cubit.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/other_asset_type.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/injection_container.dart';

class AddOtherAssetPage extends StatefulWidget {
  const AddOtherAssetPage({Key? key}) : super(key: key);
  @override
  AppState<AddOtherAssetPage> createState() => _AddOtherAssetState();
}

class _AddOtherAssetState extends AppState<AddOtherAssetPage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  String currentDayValue = "--";
  String? noOfUnits = "";
  String? valuePerUnit = "";
  @override
  void didUpdateWidget(covariant AddOtherAssetPage oldWidget) {
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
    return BlocProvider(
      create: (context) => sl<OtherAssetCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add Asset Details",
          ),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: !enableAddAssetButton
                  ? null
                  : () {
                      Map<String, dynamic> finalMap = {
                        ...privateDebtFormKey.currentState!.instantValue,
                        "currentDayValue":
                            currentDayValue == "--" ? "0" : currentDayValue
                      };

                      print(finalMap);

                      context
                          .read<OtherAssetCubit>()
                          .postOtherAsset(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<OtherAssetCubit, OtherAssetState>(
                        listener: BlocHelper.defaultBlocListener(
                            listener: (context, state) {
                      if (state is OtherAssetSaved) {
                        context.read<MainDashboardCubit>().initPage();

                        final successValue = state.otherAssetSaveResponse;
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
                                  "Add other asset",
                                  style: textTheme.headlineSmall,
                                ),
                                Text(
                                  "Uncategorized other investments including vehicles, jewelry and art.",
                                  style: textTheme.bodySmall,
                                ),
                                Text(
                                  "Fill in your asset details",
                                  style: textTheme.titleSmall,
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Name",
                                  child: AppTextFields.simpleTextField(
                                      title: "Name",
                                      name: "name",
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
                                          "A nickname to identify your property"),
                                ),
                                const EachTextField(
                                  hasInfo: false,
                                  title: "Wealth manager (optional)",
                                  child: FormBuilderTypeAhead(
                                      name: "wealthManager",
                                      hint: "Type the name of custodian",
                                      items: AppConstants.custodianList),
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Type of asset",
                                  child: AppTextFields.dropDownTextField(
                                    onChanged: (val) async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 200));
                                      checkFinalValid(val);
                                    },
                                    name: "assetType",
                                    hint: "Type or select real estate type",
                                    items: OtherAssetType.otherAssetList
                                        .map((e) => DropdownMenuItem(
                                              value: e.value,
                                              child: Text(e.name),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                EachTextField(
                                  hasInfo: false,
                                  title: "Country",
                                  child: CountriesDropdown(
                                    onChanged: checkFinalValid,
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
                                  title: "Number of units",
                                  child: AppTextFields.simpleTextField(
                                      type: TextFieldType.number,
                                      onChanged: (val) {
                                        setState(() {
                                          noOfUnits = val;
                                        });
                                        calculateCurrentValue();
                                        checkFinalValid(val);
                                      },
                                      keyboardType: TextInputType.number,
                                      name: "units",
                                      hint: "No. of Units"),
                                ),
                                EachTextField(
                                  title: "Acquisition cost",
                                  child: AppTextFields.simpleTextField(
                                      onChanged: checkFinalValid,
                                      type: TextFieldType.money,
                                      keyboardType: TextInputType.number,
                                      name: "acquisitionCost",
                                      hint: "Type the purchase price of asset"),
                                ),
                                EachTextField(
                                  title: "Acquisition date",
                                  child: FormBuilderDateTimePicker(
                                    onChanged: (selectedDate) {
                                      checkFinalValid(selectedDate);
                                    },
                                    lastDate: DateTime.now(),
                                    inputType: InputType.date,
                                    format: DateFormat("dd/MM/yyyy"),
                                    name: "acquisitionDate",
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
                                  title: "Ownership",
                                  child: AppTextFields.simpleTextField(
                                      extraValidators: [
                                        (val) {
                                          return ((int.tryParse(val ?? "0") ??
                                                      0) <=
                                                  100)
                                              ? null
                                              : "Ownership can't be greater then 100";
                                        }
                                      ],
                                      type: TextFieldType.number,
                                      keyboardType: TextInputType.number,
                                      onChanged: checkFinalValid,
                                      name: "ownerShip",
                                      hint: "Type in a figure e.g 72%"),
                                ),
                                EachTextField(
                                  title: "Value per unit (optional)",
                                  child: AppTextFields.simpleTextField(
                                      required: false,
                                      onChanged: (val) {
                                        setState(() {
                                          valuePerUnit = val;
                                        });
                                        calculateCurrentValue();
                                      },
                                      type: TextFieldType.money,
                                      keyboardType: TextInputType.number,
                                      name: "valuePerUnit",
                                      hint: "The current day value of asset"),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors
                                              .anotherCardColorForDarkTheme
                                          : AppColors
                                              .anotherCardColorForLightTheme,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Current day value"),
                                        const SizedBox(height: 8),
                                        Text(currentDayValue)
                                      ],
                                    ),
                                  ),
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
