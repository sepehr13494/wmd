import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
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
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<PrivateEquityCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AddAssetHeader(
            title: "Add private equity",
          ),
          bottomSheet: AddAssetFooter(
              buttonText: "Add asset",
              onTap: () {
                Map<String, dynamic> finalMap = {
                  ...privateEquityFormKey.currentState!.instantValue,
                };

                print(finalMap);

                // context.read<PrivateEquityCubit>().postPrivateEquity(map: finalMap);
              }),
          body: Theme(
            data: Theme.of(context).copyWith(),
            child: Stack(
              children: [
                const LeafBackground(),
                WidthLimiterWidget(
                  child: Builder(builder: (context) {
                    return BlocConsumer<PrivateEquityCubit, PrivateEquityState>(
                        listener: BlocHelper.defaultBlocListener(
                            listener: (context, state) {}),
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(children: [
                              FormBuilder(
                                key: privateEquityFormKey,
                                initialValue:
                                    AddAssetConstants.initialJsonForAddAsset,
                                child: Column(
                                  children: [
                                    Text(
                                      "Add private equity",
                                      style: textTheme.headlineSmall,
                                    ),
                                    Text(
                                      "Investment in an entity that is not publicly listed.",
                                      style: textTheme.titleMedium,
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Name",
                                      child: AppTextFields.simpleTextField(
                                          name: "name",
                                          hint:
                                              "Type the name of your private equity"),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Custodian (optional)",
                                      child: AppTextFields.simpleTextField(
                                          required: false,
                                          name: "custodian",
                                          hint: "Type the name of custodian"),
                                    ),
                                    const EachTextField(
                                      hasInfo: false,
                                      title: "Country",
                                      child: CountriesDropdown(),
                                    ),
                                    EachTextField(
                                      title: "Acquisition date",
                                      child: FormBuilderDateTimePicker(
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
                                    const EachTextField(
                                      hasInfo: false,
                                      title: "Currency",
                                      child: CurrenciesDropdown(),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: "Initial investment amount",
                                      child: AppTextFields.simpleTextField(
                                          type: TextFieldType.money,
                                          name: "initialInvestmentAmount",
                                          hint:
                                              "Book value of initial investment"),
                                    ),
                                    EachTextField(
                                      title: "Valuation date",
                                      child: FormBuilderDateTimePicker(
                                        format: DateFormat("dd/MM/yyyy"),
                                        inputType: InputType.date,
                                        name: "valuationDate",
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
                                          type: TextFieldType.money,
                                          name: "currentValue",
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
