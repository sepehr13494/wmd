import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/manager/private_debt_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
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
  DateTime? valuationDateValue;
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
          appBar: const AddAssetHeader(title: "", showExitModal: true),
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
                        listener: AssetBlocHelper.defaultBlocListener(
                            listener: (context, state) {},
                            asset: "Private debt"),
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
                                      appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_title,
                                      style: textTheme.titleSmall,
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_name_label,
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
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateDebt_inputFields_name_placeholder),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_custodian_label,
                                      child: FormBuilderTypeAhead(
                                          onChange: checkFinalValid,
                                          name: "wealthManager",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateDebt_inputFields_custodian_placeholder,
                                          items: AppConstants.custodianList),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_country_label,
                                      child: CountriesDropdown(
                                        onChanged: checkFinalValid,
                                      ),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_acquisitionDate_label,
                                      child: FormBuilderDateTimePicker(
                                        onChanged: (selectedDate) {
                                          checkFinalValid(selectedDate);
                                          setState(() {
                                            aqusitionDateValue = selectedDate;
                                          });
                                        },
                                        initialDate: valuationDateValue ??
                                            DateTime.now(),
                                        lastDate: valuationDateValue ??
                                            DateTime.now(),
                                        inputType: InputType.date,
                                        format: DateFormat("dd/MM/yyyy"),
                                        name: "investmentDate",
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: appLocalizations
                                                .assetLiabilityForms_forms_privateDebt_inputFields_acquisitionDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_currency_label,
                                      child: CurrenciesDropdown(
                                        onChanged: checkFinalValid,
                                        showExchange: true,
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_initialInvestmentAmount_label,
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          type: TextFieldType.money,
                                          name: "investmentAmount",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateDebt_inputFields_initialInvestmentAmount_placeholder),
                                    ),
                                    EachTextField(
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_valuationDate_label,
                                      child: FormBuilderDateTimePicker(
                                        firstDate: aqusitionDateValue,
                                        lastDate: DateTime.now(),
                                        format: DateFormat("dd/MM/yyyy"),
                                        inputType: InputType.date,
                                        name: "valuationDate",
                                        onChanged: (val) {
                                          setState(() {
                                            valuationDateValue = val;
                                          });
                                          checkFinalValid(val);
                                        },
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintText: appLocalizations
                                                .assetLiabilityForms_forms_privateDebt_inputFields_valuationDate_placeholder),
                                      ),
                                    ),
                                    EachTextField(
                                      hasInfo: false,
                                      title: appLocalizations
                                          .assetLiabilityForms_forms_privateDebt_inputFields_currentValue_label,
                                      child: AppTextFields.simpleTextField(
                                          onChanged: checkFinalValid,
                                          type: TextFieldType.money,
                                          name: "marketValue",
                                          hint: appLocalizations
                                              .assetLiabilityForms_forms_privateDebt_inputFields_currentValue_placeholder),
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
