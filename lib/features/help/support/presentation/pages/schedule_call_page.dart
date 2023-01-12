import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/real_estate_type.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';

class ScheduleCallPage extends StatefulWidget {
  const ScheduleCallPage({Key? key}) : super(key: key);
  @override
  AppState<ScheduleCallPage> createState() => _ScheduleCallPageState();
}

class _ScheduleCallPageState extends AppState<ScheduleCallPage> {
  final privateDebtFormKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  DateTime? aqusitionDateValue;
  @override
  void didUpdateWidget(covariant ScheduleCallPage oldWidget) {
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
      create: (context) => sl<RealEstateCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add Real Estate",
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
                          .read<RealEstateCubit>()
                          .postRealEstate(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<RealEstateCubit, RealEstateState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Real estate"),
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
                                      "Add Real Estate",
                                      style: textTheme.headlineSmall,
                                    ),
                                    Text(
                                      appLocalizations
                                          .manage_assetAndLiability_assetAndLiabilityList_realEstate_description,
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Fill in your property details",
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
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Type of real estate",
                                      child: AppTextFields.dropDownTextField(
                                        onChanged: (val) async {
                                          // setState(() {
                                          //   bottomFormKey =
                                          //       GlobalKey<FormBuilderState>();
                                          //   accountType = val;
                                          // });
                                          await Future.delayed(const Duration(
                                              milliseconds: 200));
                                          checkFinalValid(val);
                                        },
                                        name: "realEstateType",
                                        hint: "Type or select real estate type",
                                        items: RealEstateType.realEstateList
                                            .map((e) => DropdownMenuItem(
                                                  value: e.value,
                                                  child: Text(e.name),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Address (optional)",
                                      child: AppTextFields.simpleTextField(
                                          title: "Address",
                                          name: "address",
                                          required: false,
                                          // onChanged: checkFinalValid,
                                          hint: "Address"),
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
                                          keyboardType: TextInputType.number,
                                          onChanged: checkFinalValid,
                                          name: "noOfUnits",
                                          hint: "No. of Units"),
                                    ),
                                    EachTextField(
                                      title: "Acquisition cost per unit",
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "acquisitionCostPerUnit",
                                          hint: "Type a cost"),
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
                                        name: "acquisitionDate",
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
                                      title: "Your ownership",
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
                                          type: TextFieldType.number,
                                          keyboardType: TextInputType.number,
                                          onChanged: checkFinalValid,
                                          name: "ownershipPercentage",
                                          hint: "Type in a figure e.g 72%"),
                                    ),
                                    EachTextField(
                                      title: "Value per unit (optional)",
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          type: TextFieldType.money,
                                          keyboardType: TextInputType.number,
                                          name: "marketValue",
                                          hint: "Current market value"),
                                    ),
                                    EachTextField(
                                      title: "Valuation date (optional)",
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: "DD/MM/YYYY"),
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
