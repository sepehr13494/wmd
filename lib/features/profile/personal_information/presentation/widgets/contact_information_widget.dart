import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/profile/core/presentation/widgets/country_code_picker.dart';

import '../manager/personal_information_cubit.dart';

class ContactInformationWidget extends AppStatelessWidget {
  const ContactInformationWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;
    final formKey = GlobalKey<FormBuilderState>();
    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: (context, state) {
        if(state is PersonalInformationLoaded){
          formKey.currentState!.patchValue(state.getNameEntity.toJson());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact information",
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
                          title: "Personal Email",
                          child: AppTextFields.simpleTextField(
                              name: "email",
                              hint: "jassimahmed@gmail.com",
                              type: TextFieldType.email),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ExpandedIf(
                      expanded: isTablet,
                      child: Column(
                        children: [
                          EachTextField(
                            title: "Primary Phone Number",
                            child: Row(
                              children: [
                                const CountryCodePicker(),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: AppTextFields.simpleTextField(
                                      name: "phoneNumber",
                                      hint: "Enter Phone Number",
                                      type: TextFieldType.number),
                                ),
                              ],
                            ),
                          ),
                          RichText(
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
                          ),
                        ].map((e) =>
                            Padding(padding: const EdgeInsets.symmetric(
                                vertical: 8), child: e,)).toList(),
                      ),
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
