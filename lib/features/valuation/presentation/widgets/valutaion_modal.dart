import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
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
import 'package:wmd/injection_container.dart';

class ValuationModalWidget extends ModalWidget {
  final String assetType;
  final GlobalKey<FormBuilderState>? formKey = GlobalKey<FormBuilderState>();

  ValuationModalWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.assetType,
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
          };
          break;
        case AssetTypes.realEstate:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
        case AssetTypes.listedAsset:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
        case AssetTypes.listedAssetEquity:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
        case AssetTypes.listedAssetFixedIncome:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
        case AssetTypes.privateEquity:
          formMap = {
            ...formKey.currentState!.instantValue,
          };
          break;
        case AssetTypes.privateDebt:
          formMap = {
            ...formKey.currentState!.instantValue,
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
        child: Builder(builder: (context) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveHelper.bigger16Gap * 5),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // View Asset detail button
                      context.goNamed(AppRoutes.addAssetsView);
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
                      debugPrint(formStateKey.currentState.toString());
                      // debugPrint(enableAddAssetButton.toString());
                      // debugPrint(formKey.currentState!.isValid.toString());

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
    final GlobalKey<FormBuilderState> localFormKey =
        GlobalKey<FormBuilderState>();

    bool enableAddAssetButton = false;

    void checkFinalValid(value) async {
      // await Future.delayed(const Duration(milliseconds: 100));
      // bool finalValid = formKey.currentState!.isValid;

      // if (finalValid) {
      //   if (!enableAddAssetButton) {
      //     enableAddAssetButton = true;
      //   }
      // } else {
      //   if (enableAddAssetButton) {
      //     enableAddAssetButton = false;
      //   }
      // }
    }

    Widget renderForm(String type) {
      Widget entity;

      switch (type) {
        case AssetTypes.bankAccount:
          entity = BankValuationFormWidget(
            // formKey: formKey,
            buildActions: (e) => buildActions(context, e),
          );
          break;
        case AssetTypes.realEstate:
          entity = const RealEstateValuationFormWidget();
          break;
        case AssetTypes.listedAsset:
          entity = const ListedEquityValuationFormWidget();
          break;
        case AssetTypes.listedAssetEquity:
          entity = const ListedEquityValuationFormWidget();
          break;
        case AssetTypes.listedAssetFixedIncome:
          entity = const ListedEquityValuationFormWidget();
          break;
        case AssetTypes.privateEquity:
          entity = const EquityDebtValuationFormWidget();
          break;
        case AssetTypes.privateDebt:
          entity = const EquityDebtValuationFormWidget();
          break;
        default:
          entity = const EquityDebtValuationFormWidget();
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
                              "Add valuation",
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
