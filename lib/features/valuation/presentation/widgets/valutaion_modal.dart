import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/valuation/presentation/widgets/bank_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/equity_debt_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/listed_equity_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/real_estate_valuation_form.dart';
import 'package:wmd/features/valuation/presentation/widgets/valuation_form_widget.dart';

class ValuationModalWidget extends ModalWidget {
  final String assetType;
  const ValuationModalWidget({
    super.key,
    required super.title,
    super.body,
    required super.confirmBtn,
    required super.cancelBtn,
    required this.assetType,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);
    final formKey = GlobalKey<FormBuilderState>();
    bool enableAddAssetButton = false;

    Widget renderForm(String type) {
      Widget entity;

      switch (type) {
        case AssetTypes.bankAccount:
          entity = const BankValuationFormWidget();
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
                    renderForm(assetType),
                    buildActions(context, formKey, enableAddAssetButton),
                    SizedBox(height: responsiveHelper.bigger16Gap),
                  ])))
        ],
      ),
    );
  }

  // @override
  // Widget buildModalHeader(BuildContext context, {Function? onClose}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       IconButton(
  //           onPressed: () {
  //             Navigator.pop(context, false);
  //             // GoRouter.of(context).goNamed(AppRoutes.dashboard);
  //           },
  //           icon: Icon(
  //             Icons.close,
  //             color: Theme.of(context).primaryColor,
  //           )),
  //     ],
  //   );
  // }

  ///  Action Buttons Container of Modal
  Widget buildActions(BuildContext context, GlobalKey<FormBuilderState> formKey,
      bool enableAddAssetButton) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap * 5),
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () {
                // View Asset detail button
                context.goNamed(AppRoutes.addAssetsView);
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(
                cancelBtn,
              ),
            ),
            SizedBox(width: responsiveHelper.bigger16Gap),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.validate();
                if (enableAddAssetButton) {
                  Map<String, dynamic> finalMap = {
                    ...formKey.currentState!.instantValue,
                  };

                  print(finalMap);

                  // context
                  //     .read<GeneralInquiryCubit>()
                  //     .postScheduleCall(map: finalMap);
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(confirmBtn),
            )
          ],
        ));
  }
}
