import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/asset_back_button_handler.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/add_assets/core/constants.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_bloc_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/add_asset_footer.dart';
import 'package:wmd/features/asset_see_more/private_equity/data/models/private_equity_more_entity.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_bloc_helper.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/core/presentation/widgets/delete_base_widget.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/presentation/manager/edit_private_equity_cubit.dart';
import 'package:wmd/injection_container.dart';
import 'package:wmd/core/extentions/string_ext.dart';

class AddPrivateEquityPage extends StatefulWidget {
  final bool edit;
  final PrivateEquityMoreEntity? moreEntity;

  const AddPrivateEquityPage({Key? key, this.edit = false, this.moreEntity})
      : super(key: key);

  @override
  AppState<AddPrivateEquityPage> createState() => _AddPrivateEquityState();
}

class _AddPrivateEquityState extends AppState<AddPrivateEquityPage> {
  final privateEquityFormKey = GlobalKey<FormBuilderState>();
  DateTime? acquisitionDateValue;
  DateTime? valuationDateValue;
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
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PrivateEquityCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<EditPrivateEquityCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        final bool edit = widget.edit;
        return WillPopScope(
          onWillPop: () {
            return handleAssetBackButton(context);
          },
          child: Scaffold(
            appBar: const AddAssetHeader(title: "", showExitModal: true),
            bottomSheet: AddAssetFooter(
                buttonText: edit
                    ? "Save Asset"
                    : appLocalizations.common_button_addAsset,
                onTap: () {
                  if (privateEquityFormKey.currentState!.validate()) {
                    Map<String, dynamic> finalMap = {
                      ...privateEquityFormKey.currentState!.instantValue,
                    };
                    if (edit) {
                      context.read<EditPrivateEquityCubit>().putPrivateEquity(
                          map: finalMap, assetId: widget.moreEntity!.id);
                    } else {
                      context
                          .read<PrivateEquityCubit>()
                          .postPrivateEquity(map: finalMap);
                    }
                  }
                }),
            body: Theme(
              data: Theme.of(context).copyWith(),
              child: Builder(builder: (context) {
                final Widget deleteWidget = DeleteAssetBaseWidget(
                    name: appLocalizations
                        .assetLiabilityForms_assets_privateEquity,
                    realAssetName: widget.moreEntity != null
                        ? widget.moreEntity!.investmentName
                        : "",
                    onTap: () {
                      context
                          .read<EditPrivateEquityCubit>()
                          .deletePrivateEquity(assetId: widget.moreEntity!.id);
                    });
                return Stack(
                  children: [
                    const LeafBackground(),
                    WidthLimiterWidget(
                      width: edit ? 1000 : 500,
                      child: Builder(builder: (context) {
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<PrivateEquityCubit,
                                PrivateEquityState>(
                              listener: AssetBlocHelper.defaultBlocListener(
                                  listener: (context, state) {},
                                  asset: appLocalizations
                                      .assetLiabilityForms_assets_privateEquity,
                                  assetType: AssetTypes.privateEquity),
                            ),
                            BlocListener<EditPrivateEquityCubit,
                                EditAssetBaseState>(
                              listener: EditAssetBlocHelper.defaultBlocListener(
                                  type: AssetTypes.privateEquity,
                                  assetId: edit ? widget.moreEntity!.id : ""),
                            ),
                          ],
                          child: Row(
                            children: [
                              (!isMobile && edit)
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        deleteWidget,
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 32),
                                          width: 0.7,
                                          height: 200,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (isMobile && edit)
                                            ? deleteWidget
                                            : const SizedBox(),
                                        FormBuilder(
                                          key: privateEquityFormKey,
                                          initialValue: edit
                                              ? widget.moreEntity!.toFormJson()
                                              : AddAssetConstants
                                                  .initialJsonForAddAsset,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              edit
                                                  ? const SizedBox()
                                                  : Column(
                                                      children: [
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_heading_privateEquity,
                                                          style: textTheme
                                                              .headlineSmall,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        const SizedBox(
                                                            height: 24),
                                                        Text(
                                                          appLocalizations
                                                              .assetLiabilityForms_subHeading_privateEquity,
                                                          style: textTheme
                                                              .titleMedium,
                                                        ),
                                                      ],
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
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_privateEquity_inputFields_name_errorMessage,
                                                        onChanged:
                                                            checkFinalValid,
                                                        extraValidators: [
                                                          (val) {
                                                            return ((val?.length ??
                                                                        0) >
                                                                    100
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
                                                    enabled: !edit,
                                                    required: false,
                                                    onChange: checkFinalValid,
                                                    name: "wealthManager",
                                                    hint: appLocalizations
                                                        .assetLiabilityForms_forms_privateEquity_inputFields_custodian_placeholder,
                                                    items: AppConstants
                                                        .custodianList),
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
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_privateEquity_inputFields_acquisitionDate_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_privateEquity_inputFields_acquisitionDate_label,
                                                child:
                                                    FormBuilderDateTimePicker(
                                                  enabled: !edit,
                                                  inputType: InputType.date,
                                                  format:
                                                      DateFormat("dd/MM/yyyy"),
                                                  initialDate:
                                                      valuationDateValue ??
                                                          DateTime.now(),
                                                  lastDate:
                                                      valuationDateValue ??
                                                          DateTime.now(),
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators.required(
                                                        errorText: appLocalizations
                                                            .assetLiabilityForms_forms_privateEquity_inputFields_acquisitionDate_errorMessage)
                                                  ]),
                                                  name: "investmentDate",
                                                  onChanged: (selectedDate) {
                                                    checkFinalValid(
                                                        selectedDate);
                                                    setState(() {
                                                      acquisitionDateValue =
                                                          selectedDate;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
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
                                                  enabled: !edit,
                                                  onChanged: checkFinalValid,
                                                ),
                                              ),
                                              EachTextField(
                                                hasInfo: false,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_label,
                                                child: AppTextFields.simpleTextField(
                                                    enabled: !edit,
                                                    errorMsg: appLocalizations
                                                        .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_errorMessage,
                                                    onChanged: checkFinalValid,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    title:
                                                        "Initial investment amount",
                                                    type: TextFieldType.money,
                                                    name: "investmentAmount",
                                                    hint: appLocalizations
                                                        .assetLiabilityForms_forms_privateEquity_inputFields_initialInvestmentAmount_placeholder),
                                              ),
                                              EachTextField(
                                                tooltipText: appLocalizations
                                                    .assetLiabilityForms_forms_privateEquity_inputFields_valuationDate_tooltip,
                                                title: appLocalizations
                                                    .assetLiabilityForms_forms_privateEquity_inputFields_valuationDate_label,
                                                child:
                                                    FormBuilderDateTimePicker(
                                                  enabled: !edit,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                    FormBuilderValidators.required(
                                                        errorText: appLocalizations
                                                            .assetLiabilityForms_forms_privateEquity_inputFields_valuationDate_errorMessage)
                                                  ]),
                                                  // enabled: acquisitionDateValue != null,
                                                  format:
                                                      DateFormat("dd/MM/yyyy"),
                                                  inputType: InputType.date,
                                                  firstDate:
                                                      acquisitionDateValue,
                                                  lastDate: DateTime.now(),
                                                  name: "valuationDate",
                                                  onChanged: (val) {
                                                    setState(() {
                                                      valuationDateValue = val;
                                                    });
                                                    checkFinalValid(val);
                                                  },
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
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
                                                child: AppTextFields
                                                    .simpleTextField(
                                                        enabled: !edit,
                                                        errorMsg: appLocalizations
                                                            .assetLiabilityForms_forms_privateEquity_inputFields_currentValue_errorMessage,
                                                        onChanged:
                                                            checkFinalValid,
                                                        title: "Current value",
                                                        type:
                                                            TextFieldType.money,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        name: "marketValue",
                                                        extraValidators: [
                                                          (val) {
                                                            return (val !=
                                                                        null &&
                                                                    val != "" &&
                                                                    val.convertMoneyToInt() ==
                                                                        0)
                                                                ? appLocalizations
                                                                    .common_errors_required
                                                                : null;
                                                          }
                                                        ],
                                                        hint: appLocalizations
                                                            .assetLiabilityForms_forms_privateEquity_inputFields_currentValue_placeholder),
                                              ),
                                              const SizedBox(height: 60),
                                            ]
                                                .map((e) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      child: e,
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
