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

class SuccessModalWidget extends ModalWidget {
  final AssetTypes assetType;

  const SuccessModalWidget({
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildActions(context, formKey, enableAddAssetButton),
                  ]))
        ],
      ),
    );
  }

  ///  Action Buttons Container of Modal
  Widget buildActions(BuildContext context, GlobalKey<FormBuilderState> formKey,
      bool enableAddAssetButton) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap * 5),
        child: RowOrColumn(
          showRow: !isMobile,
          children: [
            ExpandedIf(
              expanded: !isMobile,
              child: OutlinedButton(
                onPressed: () {
                  // View Asset detail button
                  context.goNamed(AppRoutes.addAssetsView);
                },
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
                child: Text(
                  cancelBtn,
                ),
              ),
            ),
            !isMobile
                ? SizedBox(width: responsiveHelper.bigger16Gap)
                : SizedBox(height: responsiveHelper.bigger16Gap),
            ExpandedIf(
                expanded: !isMobile,
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(confirmBtn),
                ))
          ],
        ));
  }
}
