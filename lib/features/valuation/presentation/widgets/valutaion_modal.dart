import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/valuation/presentation/manager/valuation_cubit.dart';
import 'package:wmd/features/valuation/presentation/widgets/bank_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/equity_debt_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/listed_equity_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/real_estate_valuation_form.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ValuationModalWidget extends ModalWidget {
  final String assetId;
  final String assetType;
  final GlobalKey<FormBuilderState>? formKey = GlobalKey<FormBuilderState>();

  ValuationModalWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.assetType,
    required this.assetId,
    // this.formKey = GlobalKey<FormBuilderState>(),
  });

  ///  Action Buttons Container of Modal
  Widget buildActions(
      BuildContext context, GlobalKey<FormBuilderState> formStateKey) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    bool enableAddAssetButton = false;

    Map<String, dynamic> renderSubmitData(
        String type, GlobalKey<FormBuilderState> formKey) {
      Map<String, dynamic> formMap;

      switch (type) {
        case AssetTypes.bankAccount:
          formMap = {
            ...formKey.currentState!.instantValue,
            "wealthType": "Asset",
            "assetOrLiabilityId": assetId,
            "type": "Buy"
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
        default:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
      }

      return formMap;
    }

    return BlocProvider(
        create: (context) => sl<AssetValuationCubit>(),
        child: BlocConsumer<AssetValuationCubit, AssetValuationState>(listener:
            BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is SuccessState) {
            GlobalFunctions.showSnackBar(context, 'Valuation added',
                type: "success");
            Navigator.pop(context, false);
          }
        }), builder: (context, state) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveHelper.bigger16Gap * 5),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    child: Text(
                      cancelBtn,
                    ),
                  ),
                  SizedBox(width: responsiveHelper.bigger16Gap),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("formKey.currentState");
                      // debugPrint(formKey.currentState!.initialValue.toString());
                      debugPrint(
                          formStateKey?.currentState!.instantValue.toString());

                      formStateKey.currentState?.validate();
                      if (formStateKey.currentState!.isValid) {
                        Map<String, dynamic> finalMap =
                            renderSubmitData(assetType, formStateKey);

                        print(finalMap);

                        context
                            .read<AssetValuationCubit>()
                            .postValuation(map: finalMap);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    child: Text(confirmBtn),
                  )
                ],
              ));
        }));
  }

  @override
  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    Widget renderForm(String type) {
      Widget entity;

      switch (type) {
        case AssetTypes.bankAccount:
          entity = BankValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.realEstate:
          entity = RealEstateValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.listedAsset:
          entity = ListedEquityValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.listedAssetEquity:
          entity = ListedEquityValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.listedAssetFixedIncome:
          entity = ListedEquityValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.privateEquity:
          entity = EquityDebtValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.privateDebt:
          entity = EquityDebtValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
        default:
          entity = EquityDebtValuationFormWidget(
            buildActions: (e) => buildActions(context, e),
          );
          break;
      }

      return entity;
    }

    return SizedBox(
      width: double.infinity,
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.8
          : MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          buildModalHeader(context),
          Expanded(
              flex: 2,
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
                              appLocalizations.assets_valuationModal_heading,
                              style: appTextTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                    renderForm(assetType),
                    // FormBuilder(
                    //   key: localFormKey,
                    //   child: renderForm(assetType),
                    // ),
                    // buildActions(context, localFormKey),
                    SizedBox(height: responsiveHelper.bigger16Gap),
                  ])))
        ],
      ),
    );
  }
}
