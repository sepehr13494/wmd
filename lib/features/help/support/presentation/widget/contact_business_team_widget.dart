import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/help/support/data/models/contact_reason.dart';

class ContactBusinessWidget extends ModalWidget {
  final formKey = GlobalKey<FormBuilderState>();

  ContactBusinessWidget({
    super.key,
    required super.title,
    super.body,
    super.confirmBtn,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SizedBox(
        width: double.infinity,
        height: isMobile
            ? MediaQuery.of(context).size.height * 0.7
            : MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          buildModalHeader(context),
          SingleChildScrollView(
              padding: responsiveHelper.paddingForMobileTab,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Contact our business support team",
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Contact us if you have any questions. We will get back to you as soon as possible.",
                            style: textTheme.bodySmall,
                          ),
                        ]),
                    const SizedBox(
                      height: 24,
                    ),
                    FormBuilder(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextFields.dropDownTextField(
                                name: "loanType",
                                hint: "Select the reason",
                                items: ContactReason.contactReasonList
                                    .map((e) => DropdownMenuItem(
                                          value: e.value,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              AppTextFields.simpleTextField(
                                  title: "Name",
                                  name: "message",
                                  minLines: 5,
                                  extraValidators: [
                                    (val) {
                                      return (val != null && val.length > 100)
                                          ? "Name cannot be more than 100 characters"
                                          : null;
                                    }
                                  ],
                                  hint: "Type your message"),
                            ])),
                    const SizedBox(height: 24),
                    buildActionContainer(context)
                  ]))
        ]));
  }

  ///  Action Buttons Container of Modal
  @override
  Widget buildActionContainer(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveHelper.bigger16Gap * 5),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoutes.main);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(confirmBtn),
            ))
          ],
        ));
  }
}
