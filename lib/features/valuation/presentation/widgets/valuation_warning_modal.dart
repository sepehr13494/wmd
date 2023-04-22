import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValuationWarningModal extends ModalWidget {
  const ValuationWarningModal({
    super.key,
    required super.title,
    super.body,
    super.confirmBtn,
    super.cancelBtn,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
                child: Column(children: [
              buildModalHeader(context),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      title,
                      style: textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsiveHelper.bigger16Gap * 3.5),
                        child: Text(
                          body,
                          style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    buildActionContainer(context),
                  ]))
            ]))));
  }
}
