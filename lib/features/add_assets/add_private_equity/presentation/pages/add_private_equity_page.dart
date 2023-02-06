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
          appBar: const AddAssetHeader(title: "", showExitModal: true),
          bottomSheet: AddAssetFooter(
              buttonText: "Save asset",
              onTap: () {
                privateEquityFormKey.currentState?.validate();
                if (enableAddAssetButton) {
                  Map<String, dynamic> finalMap = {
                    ...privateEquityFormKey.currentState!.instantValue,
                  };
                  context
                      .read<PrivateEquityCubit>()
                      .postPrivateEquity(map: finalMap);
                }
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
                            asset: appLocalizations
                                .assetLiabilityForms_assets_privateEquity,
                            assetType: AssetTypes.privateEquity),
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
                                      appLocalizations
                                          .assetLiabilityForms_heading_privateEquity,
                                      style: textTheme.headlineSmall,
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_subHeading_privateEquity,
                                      style: textTheme.titleMedium,
                                    ),
                                    Text(
                                      appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_title,
                                      style: textTheme.titleSmall,
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_name_label,
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
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateEquity_inputFields_name_placeholder),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_custodian_label,
                                      child: FormBuilderTypeAhead(
                                          onChange: checkFinalValid,
                                          name: "custodian",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateEquity_inputFields_custodian_placeholder,
                                          items: AppConstants.custodianList),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_country_label,
                                      child: CountriesDropdown(
                                        onChanged: checkFinalValid,
                                      ),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_acquisitionDate_label,
                                      child: FormBuilderDateTimePicker(
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        lastDate: DateTime.now(),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required()
                                        ]),
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
                                            hintText: appLocalizations
                                                .assetLiabilityForms_forms_privateEquity_inputFields_acquisitionDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_currency_label,
                                      child: CurrenciesDropdown(
                                        onChanged: checkFinalValid,
                                        showExchange: true,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_label,
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          title: "Initial investment amount",
                                          type: TextFieldType.money,
                                          name: "investmentAmount",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_valuationDate_label,
                                      child: FormBuilderDateTimePicker(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required()
                                        ]),
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
                                            hintText: appLocalizations
                                                .assetLiabilityForms_forms_privateEquity_inputFields_valuationDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateEquity_inputFields_currentValue_label,
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          title: "Current value",
                                          type: TextFieldType.money,
                                          name: "marketValue",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateEquity_inputFields_currentValue_placeholder),
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
