import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/injection_container.dart';

class AddPrivateEquityPage extends StatefulWidget {
  const AddPrivateEquityPage({Key? key}) : super(key: key);
  @override
  AppState<AddPrivateEquityPage> createState() => _AddPrivateEquityState();
}

class _AddPrivateEquityState extends AppState<AddPrivateEquityPage> {
  final privateEquityFormKey = GlobalKey<FormBuilderState>();
  DateTime? acquisitionDateValue;
  bool enableAddAssetButton = false;
  @override
  void didUpdateWidget(covariant AddPrivateEquityPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = privateEquityFormKey.currentState!.isValid;
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
      create: (context) => sl<PrivateEquityCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(title: "Add asset", showExitModal: true),
          bottomSheet: AddAssetFooter(
              buttonText: "Save asset",
              onTap: !enableAddAssetButton
                  ? null
                  : () {
                      Map<String, dynamic> finalMap = {
                        ...privateEquityFormKey.currentState!.instantValue,
                      };
                      context
                          .read<PrivateEquityCubit>()
                          .postPrivateEquity(map: finalMap);
                    }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<PrivateEquityCubit, PrivateEquityState>(
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Private equity"),
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(children: [
                              FormBuilder(
                                key: privateEquityFormKey,
                                initialValue:
                                    AddAssetConstants.initialJsonForAddAsset,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Add private equity",
                                      style: textTheme.headlineSmall,
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "Investment in an entity that is not publicly listed.",
                                      style: textTheme.titleMedium,
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Name",
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          extraValidators: [
                                            (val) {
                                              return ((val?.length ?? 0) > 100
                                                  ? "Name must be at most 100 characters"
                                                  : null);
                                            }
                                          ],
                                          title: "Name",
                                          name: "investmentName",
                                          hint:
                                              "Type the name of your private equity"),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Custodian (optional)",
                                      child: FormBuilderTypeAhead(
                                          onChange: checkFinalValid,
                                          name: "custodian",
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
                                        validator:
                                            FormBuilderValidators.required(),
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        lastDate: DateTime.now(),
                                        name: "investmentDate",
                                        onChanged: (selectedDate) {
                                          checkFinalValid(selectedDate);
                                          setState(() {
                                            acquisitionDateValue = selectedDate;
                                          });
                                        },
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
                                          title: "Initial investment amount",
                                          type: TextFieldType.money,
                                          name: "investmentAmount",
                                          hint:
                                              "Book value of initial investment"),
                                    ),
                                    EachTextField(
                                      title: "Valuation date",
                                      child: FormBuilderDateTimePicker(
                                        validator:
                                            FormBuilderValidators.required(),
                                        enabled: acquisitionDateValue != null,
                                        format: DateFormat("dd/MM/yyyy"),
                                        inputType: InputType.date,
                                        firstDate: acquisitionDateValue,
                                        lastDate: DateTime.now(),
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
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Current value",
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          title: "Current value",
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
