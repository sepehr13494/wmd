import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/country_code_picker.dart';
import 'package:wmd/global_functions.dart';

import '../manager/personal_information_cubit.dart';

class ContactInformationWidget extends StatefulWidget {
  const ContactInformationWidget({Key? key}) : super(key: key);

  @override
  AppState<ContactInformationWidget> createState() => _ContactInformationWidgetState();
}

class _ContactInformationWidgetState extends AppState<ContactInformationWidget> {

  TextEditingController emailController = TextEditingController();
  bool enableSubmitButton = false;
  final formKey = GlobalKey<FormBuilderState>();
  late Map<String,dynamic> lastValue;
  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
    if (finalValid && lastValue.toString() != instantValue.toString()) {
      if (!enableSubmitButton) {
        setState(() {
          enableSubmitButton = true;
        });
      }
    } else {
      if (enableSubmitButton) {
        setState(() {
          enableSubmitButton = false;
        });
      }
    }
  }
  
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;
    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: (context, state) {
        if (state is PersonalInformationLoaded) {
          var json = state.getNameEntity.toJson();
          json.removeWhere((key, value) => (value == "" || value == null));
          formKey.currentState!.patchValue(json);
          emailController.text = state.getNameEntity.email;
          lastValue = formKey.currentState!.instantValue;
        }
        if (state is SuccessStatePhone) {
          setState(() {
            lastValue = formKey.currentState!.instantValue;
            checkFinalValid("");
          });
          GlobalFunctions.showSnackBar(
              context,
              appLocalizations
                  .profile_tabs_preferences_toast_changePasswordDescription,
              type: "success");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Builder(
          builder: (context) {
            return FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.profile_tabs_personal_headings_contactInfo,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  RowOrColumn(
                      rowCrossAxisAlignment: CrossAxisAlignment.start,
                      showRow: isTablet,
                      children: [
                        ExpandedIf(
                          expanded: isTablet,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: EachTextField(
                                hasInfo: false,
                                title: appLocalizations.profile_tabs_personal_fields_label_email,
                                child: Builder(builder: (context) {
                                  return TextField(
                                    enabled: false,
                                    style: TextStyle(color: Colors.grey[500]),
                                    controller: emailController,
                                  );
                                })),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ExpandedIf(
                          expanded: isTablet,
                          child: Column(
                            children: [
                              EachTextField(
                                hasInfo: false,
                                title: appLocalizations.profile_tabs_personal_fields_label_primaryPhoneNumber,
                                child: Row(
                                  children: [
                                    CountryCodePicker(onChange: checkFinalValid),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: AppTextFields.simpleTextField(
                                          name: "phoneNumber",
                                          hint: ".",
                                          type: TextFieldType.number,
                                          keyboardType: TextInputType.number,
                                        onChanged: checkFinalValid
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /* RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                    "To keep your account secure, we need to verify your phone number,",
                                    style: textTheme.bodyMedium,
                                  ),
                                  TextSpan(
                                    text: " Send verification code",
                                    style: textTheme.bodyMedium!.toLinkStyle(
                                        context),
                                  )
                                ]),
                              ),*/
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: SizedBox(
                                  width: isTablet ? 160 : null,
                                  child: ElevatedButton(
                                    onPressed: !enableSubmitButton
                                        ? null
                                        : () {
                                      if (formKey.currentState!.validate()) {
                                        debugPrint(formKey
                                            .currentState!.instantValue
                                            .toString());

                                        context
                                            .read<PersonalInformationCubit>()
                                            .setNumber(
                                                map: formKey
                                                    .currentState!.instantValue);
                                      }
                                    },
                                    child: Text(appLocalizations.profile_tabs_preferences_button_applyChanges),
                                  ),
                                ),
                              ),
                            ]
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 8),
                                      child: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      ])
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
