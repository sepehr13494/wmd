import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/help/support/data/models/contact_reason.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ContactBusinessWidget extends ModalWidget {
  final formKey = GlobalKey<FormBuilderState>();
  bool enableSubmitButton = false;

  ContactBusinessWidget({
    super.key,
    required super.title,
    super.body,
    super.confirmBtn,
  });

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    if (finalValid) {
      if (!enableSubmitButton) {
        enableSubmitButton = true;
      }
    } else {
      if (enableSubmitButton) {
        enableSubmitButton = false;
      }
    }
  }

  @override
  Widget buildDialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SingleChildScrollView(
        child: SizedBox(
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
                                      name: "reason",
                                      hint: "Select the reason",
                                      items: ContactReason.contactReasonList
                                          .map((e) => DropdownMenuItem(
                                                value: e.value,
                                                child: Text(e.name),
                                              ))
                                          .toList(),
                                      onChanged: checkFinalValid),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextFields.simpleTextField(
                                      title: "Inquiry",
                                      name: "enquiryText",
                                      minLines: 5,
                                      onChanged: checkFinalValid,
                                      extraValidators: [
                                        (val) {
                                          return (val != null &&
                                                  val.length > 100)
                                              ? "Inquiry cannot be more than 100 characters"
                                              : null;
                                        }
                                      ],
                                      hint: "Type your message"),
                                ])),
                        const SizedBox(height: 16),
                        buildActionContainer(context)
                      ]))
            ])));
  }

  ///  Action Buttons Container of Modal
  @override
  Widget buildActionContainer(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return BlocProvider(
        create: (context) => sl<GeneralInquiryCubit>(),
        child: BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
            listener: (context, state) {
          debugPrint(state.toString());

          if (state is GeneralInquirySaved) {
            final successValue = state.status;
            GlobalFunctions.showSnackBar(context, successValue,
                type: "success");
            Navigator.pop(context, false);
          } else if (state is ErrorState) {
            GlobalFunctions.showSnackBar(context, state.failure.message,
                color: Colors.red[800], type: "error");
            Navigator.pop(context, false);
          }
        }, builder: (context, state) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveHelper.bigger16Gap * 5),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: enableSubmitButton
                        ? () {
                            Map<String, dynamic> finalMap = {
                              ...formKey.currentState!.instantValue,
                            };

                            print(finalMap);
                            print(formKey.currentState!.isValid);

                            context
                                .read<GeneralInquiryCubit>()
                                .postGeneralInquiry(map: finalMap);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50)),
                    child: Text(confirmBtn),
                  ))
                ],
              ));
        }));
  }
}
