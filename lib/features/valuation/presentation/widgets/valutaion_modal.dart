import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_params.dart';
import 'package:wmd/features/asset_see_more/core/presentation/manager/asset_see_more_cubit.dart';
import 'package:wmd/features/valuation/presentation/manager/valuation_cubit.dart';
import 'package:wmd/features/valuation/presentation/widgets/bank_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/equity_debt_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/liability_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/listed_equity_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/real_estate_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/valuation_warning_modal.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ValuationModalWidget extends ModalWidget {
  final String assetId;
  final String assetType;
  final bool? isEdit;
  final String? valuationId;
  final GlobalKey<FormBuilderState>? formKey = GlobalKey<FormBuilderState>();

  ValuationModalWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.assetType,
    this.isEdit = false,
    this.valuationId,
    required this.assetId,
    // this.formKey = GlobalKey<FormBuilderState>(),
  });

  void handleModalClose(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ValuationWarningModal(
            title: "All changes will be discarded",
            body: "This action cannot be undone",
            confirmBtn: 'Discard changes',
            cancelBtn: "Go back to form");
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
        Navigator.pop(context, false);
      }
      return isConfirm;
    });
  }

  void handleFormSubmit(
      formStateKey, renderSubmitData, BuildContext context, bool isEdit) {
    debugPrint("formKey.currentState");
    // debugPrint(formKey.currentState!.initialValue.toString());
    debugPrint(formStateKey?.currentState!.instantValue.toString());

    formStateKey.currentState?.validate();
    if (formStateKey.currentState!.isValid) {
      Map<String, dynamic> finalMap = renderSubmitData(assetType, formStateKey);
      if (isEdit) {
        context.read<AssetValuationCubit>().updateValuation(map: finalMap);
      } else {
        context.read<AssetValuationCubit>().postValuation(map: finalMap);
      }
    }
  }

  void handleFormSubmitOnEdit(formStateKey, renderSubmitData, context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ValuationWarningModal(
            title: "Save new data entry?",
            body: "This action cannot be undone",
            confirmBtn: 'Save',
            cancelBtn: "Cancel");
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
        handleFormSubmit(formStateKey, renderSubmitData, context, true);
      }
      return isConfirm;
    });
  }

  ///  Action Buttons Container of Modal
  Widget buildActions(
      BuildContext context,
      GlobalKey<FormBuilderState> formStateKey,
      Function? setFormValues,
      bool enableAddAssetButton) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    debugPrint("enableAddAssetButton");
    debugPrint("enableAddAssetButton");
    debugPrint(enableAddAssetButton.toString());
    debugPrint("enableAddAssetButton");
    // bool enableAddAssetButton = false;

    Map<String, dynamic> renderSubmitData(
        String type, GlobalKey<FormBuilderState> formKey) {
      Map<String, dynamic> formMap;

      switch (type) {
        case AssetTypes.bankAccount:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
            "type": "Buy",
            // "valuatedAt": DateTime.now(),
          };
          break;
        case AssetTypes.realEstate:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.listedAsset:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.listedAssetEquity:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.listedAssetFixedIncome:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.privateEquity:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.privateDebt:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        case AssetTypes.otherAsset:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
          };
          break;
        default:
          formMap = {
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
            ...formKey.currentState!.instantValue,
          };
          break;
      }

      if (isEdit == true) {
        formMap['transactionId'] = valuationId;
      }

      return formMap;
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              if (isEdit == true) {
                return sl<AssetValuationCubit>()
                  ..getValuationById(map: {"id": valuationId});
              } else {
                return sl<AssetValuationCubit>();
              }
            },
          ),
          BlocProvider(
              create: (context) => sl<AssetSeeMoreCubit>()
                ..getAssetSeeMore(
                  GetSeeMoreParams(
                    type: assetType,
                    assetId: assetId,
                  ),
                )),
        ],
        child: BlocConsumer<AssetValuationCubit, AssetValuationState>(listener:
            BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is SuccessState) {
            GlobalFunctions.showSnackBar(context, 'Valuation added',
                type: "success");

            Navigator.of(context, rootNavigator: true).pop();
            // Navigator.pop(context, false);
          }

          if (state is GetValuationLoaded) {
            var json = state.entity.toFormJson();

            setFormValues!(json);
          }
        }), builder: (context, state) {
          return BlocConsumer<AssetSeeMoreCubit, AssetSeeMoreState>(listener:
              BlocHelper.defaultBlocListener(listener: (context, seeMoreState) {
            if (seeMoreState is GetSeeMoreLoaded) {
              debugPrint("working see more 2");
              debugPrint(seeMoreState.getAssetSeeMoreEntity.toString());
              dynamic json = seeMoreState.getAssetSeeMoreEntity as dynamic;

              // debugPrint(json?.accountType.toString());
              // debugPrint(json?.accountType.toString());

              try {
                if (json?.currencyCode != null) {
                  Map<String, dynamic> formDataTemp = {};

                  if (isEdit == null || isEdit == false) {
                    formDataTemp['currencyCode'] =
                        Currency.getCurrencyFromString(json?.currencyCode);
                  }

                  bool isAcquisitionDateAvailable = false;
                  bool isSavingOrCurrentBank = false;

                  try {
                    isAcquisitionDateAvailable = json?.acquisitionDate != null;
                  } catch (e) {
                    // Handle the exception if the variable is not available
                  }

                  try {
                    isSavingOrCurrentBank =
                        json?.accountType == 'SavingAccount' ||
                            json?.accountType == 'CurrentAccount';
                  } catch (e) {
                    // Handle the exception if the variable is not available
                  }

                  if (isAcquisitionDateAvailable) {
                    formDataTemp['acquisitionDate'] = json?.acquisitionDate;
                  }

                  if (isSavingOrCurrentBank) {
                    formDataTemp['isSavingOrCurrentBank'] =
                        isSavingOrCurrentBank;
                  }

                  setFormValues!(formDataTemp);
                } else {
                  setFormValues!(
                      {'currencyCode': Currency.getCurrencyFromString('USD')});
                }
              } catch (e) {
                debugPrint('Format erro detail:');
                debugPrint('Format erro detail: $e');
              }
            }
          }), builder: (context, seeMoreState) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsiveHelper.bigger16Gap * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (isEdit == true) {
                          handleModalClose(context);
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      child: Text(
                        cancelBtn,
                      ),
                    ),
                    SizedBox(width: responsiveHelper.bigger16Gap),
                    ElevatedButton(
                      onPressed: isEdit == true && !enableAddAssetButton
                          ? null
                          : () {
                              if (isEdit == true) {
                                handleFormSubmitOnEdit(
                                  formStateKey,
                                  renderSubmitData,
                                  context,
                                );
                              } else {
                                handleFormSubmit(formStateKey, renderSubmitData,
                                    context, false);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      child: Text(confirmBtn),
                    )
                  ],
                ));
          });
        }));
  }

  @override
  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    Widget renderForm(String type, bool isEdit) {
      Widget entity;

      switch (type) {
        case AssetTypes.bankAccount:
          entity = BankValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.realEstate:
          entity = RealEstateValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.otherAsset:
          entity = RealEstateValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.otherAssets:
          entity = RealEstateValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.listedAsset:
          entity = ListedEquityValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.listedAssetEquity:
          entity = ListedEquityValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.listedAssetFixedIncome:
          entity = ListedEquityValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.privateEquity:
          entity = EquityDebtValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.privateDebt:
          entity = EquityDebtValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        case AssetTypes.loanLiability:
          entity = LoanLiabilityValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
        default:
          entity = EquityDebtValuationFormWidget(
              buildActions: (e, callbackF, enableAddAssetButton) =>
                  buildActions(
                      context, e, (x) => callbackF(x), enableAddAssetButton),
              isEdit: isEdit);
          break;
      }

      return entity;
    }

    return SizedBox(
      width: double.infinity,
      height: isMobile
          ? min(MediaQuery.of(context).size.height * 0.8, 625)
          : MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          buildModalHeader(context, onClose: () {
            if (isEdit == true) {
              handleModalClose(context);
            } else {
              Navigator.pop(context, false);
            }
          }),
          Expanded(
              flex: 2,
              child: Scrollbar(
                trackVisibility: true,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isEdit!
                                    ? "Edit Valuation"
                                    : appLocalizations
                                        .assets_valuationModal_heading,
                                style: appTextTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                      renderForm(assetType, isEdit!),
                      // FormBuilder(
                      //   key: localFormKey,
                      //   child: renderForm(assetType),
                      // ),
                      // buildActions(context, localFormKey),
                      SizedBox(height: responsiveHelper.bigger16Gap),
                    ])),
              ))
        ],
      ),
    );
  }
}
