import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/help/support/data/models/contact_reason.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final appLocalizations = AppLocalizations.of(context);
    final contactReasonList = ContactReason.contactReasonList(context);

    return BlocProvider(
        create: (context) => sl<GeneralInquiryCubit>(),
        child: BlocConsumer<GeneralInquiryCubit, GeneralInquiryState>(
            listener: (context, state) {
          debugPrint(state.toString());

          if (state is ErrorState) {
            GlobalFunctions.showSnackBar(context, state.failure.message,
                color: Colors.red[800], type: "error");
            Navigator.pop(context, false);
          }
        }, builder: (context, state) {
          if (state is GeneralInquiryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {
            return SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: isMobile
                        ? min(MediaQuery.of(context).size.height * 0.55, 625)
                        : MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                        child: Column(children: [
                      buildModalHeader(context),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: textTheme.bodySmall!.color!
                                    .withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              appLocalizations
                                  .common_submitEnquiryModal_emailSent_title,
                              style: textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        responsiveHelper.bigger16Gap * 3.5),
                                child: Text(
                                  appLocalizations
                                      .common_submitEnquiryModal_emailSent_description,
                                  style: textTheme.bodyMedium!
                                      .copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                          ]))
                    ]))));
          } else {
            return SingleChildScrollView(
                child: SizedBox(
                    width: isMobile
                        ? double.infinity
                        : max(MediaQuery.of(context).size.width * 0.7,
                            min(660, MediaQuery.of(context).size.width)),
                    height: isMobile
                        ? min(MediaQuery.of(context).size.height * 0.7, 625)
                        : max(MediaQuery.of(context).size.height * 0.5,
                            min(525, MediaQuery.of(context).size.width)),
                    child: Column(children: [
                      buildModalHeader(context),
                      SingleChildScrollView(
                          padding: responsiveHelper.paddingForMobileTab,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: SvgPicture.asset(
                                              "assets/images/help/email_icon.svg",
                                              semanticsLabel: 'My SVG Picture',
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fitHeight)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  responsiveHelper.bigger16Gap *
                                                      3),
                                          child: Text(
                                            appLocalizations
                                                .support_card_contactClientService_title,
                                            style: textTheme.titleLarge,
                                            textAlign: TextAlign.center,
                                          )),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        appLocalizations
                                            .common_submitEnquiryModal_description,
                                        style: textTheme.bodySmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 24,
                                ),
                                FormBuilder(
                                    key: formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // AppTextFields.simpleTextField(
                                          //   required: false,
                                          //   title: "reason",
                                          //   name: "reason",
                                          //   minLines: 1,
                                          //   onChanged: checkFinalValid,
                                          //   extraValidators: [
                                          //     (val) {
                                          //       return (val != null &&
                                          //               val.length > 100)
                                          //           ? "Inquiry cannot be more than 100 characters"
                                          //           : null;
                                          //     }
                                          //   ],
                                          //   hint: appLocalizations
                                          //       .common_submitEnquiryModal_subject_placeholder,
                                          // ),
                                          // FormBuilderSearchableDropdown<
                                          //     ContactReason>(
                                          //   name: "reason",
                                          //   hint: "Select",
                                          //   showSearchBox: false,
                                          //   items: contactReasonList,
                                          //   itemAsString: (ContactReason val) =>
                                          //       val.name,
                                          //   itemBuilder:
                                          //       (context, currency, _) {
                                          //     return Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: Text(currency.name),
                                          //     );
                                          //   },
                                          // ),
                                          // AppTextFields.dropDownTextField(
                                          //     name: "reason",
                                          //     hint: appLocalizations
                                          //         .common_submitEnquiryModal_placeholder,
                                          //     fontSize: 11,
                                          //     items: contactReasonList
                                          //         .map((e) => DropdownMenuItem(
                                          //               value: e.value,
                                          //               child: SizedBox(
                                          //                   width: MediaQuery.of(
                                          //                               context)
                                          //                           .size
                                          //                           .width *
                                          //                       0.86,
                                          //                   child: Text(
                                          //                     e.name,
                                          //                   )),
                                          //             ))
                                          //         .toList()
                                          //     // as List<
                                          //     //     DropdownMenuItem<
                                          //     //         dynamic>>
                                          //     ,
                                          //     onChanged: checkFinalValid),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          AppTextFields.simpleTextField(
                                              name: "reason",
                                              minLines: 5,
                                              onChanged: checkFinalValid,
                                              extraValidators: [
                                                (val) {
                                                  return (val != null &&
                                                          val.length > 100)
                                                      ? "Enquiry cannot be more than 100 characters"
                                                      : null;
                                                }
                                              ],
                                              hint: appLocalizations
                                                  .common_submitEnquiryModal_textarea_placeholder),
                                        ])),
                                const SizedBox(height: 16),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            responsiveHelper.bigger16Gap * 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                          onPressed: () async {
                                            formKey.currentState?.validate();

                                            await Future.delayed(const Duration(
                                                milliseconds: 100));
                                            bool finalValid =
                                                formKey.currentState!.isValid;

                                            if (finalValid) {
                                              Map<String, dynamic> finalMap = {
                                                ...formKey
                                                    .currentState!.instantValue,
                                                "enquiryText": ""
                                              };

                                              context
                                                  .read<GeneralInquiryCubit>()
                                                  .postGeneralInquiry(
                                                      map: finalMap);
                                            }
                                          }
                                          // : null
                                          ,
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(100, 50)),
                                          child: Text(confirmBtn),
                                        ))
                                      ],
                                    ))
                              ]))
                    ])));
          }
        }));
  }

  @override
  Widget buildModalHeader(BuildContext context, {Function? onClose}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context, false);
              // GoRouter.of(context).goNamed(AppRoutes.dashboard);
            },
            icon: Icon(
              Icons.close,
              color: Theme.of(context).primaryColor,
            )),
      ],
    );
  }
}
