import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/global_functions.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);
  @override
  AppState<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState
    extends AppState<PersonalInformationWidget> {
  bool enableSubmitButton = false;
  final formKey = GlobalKey<FormBuilderState>();

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    if (finalValid) {
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
          json.removeWhere((key, value) => value == "");
          formKey.currentState!.patchValue(json);
        }

        if (state is SuccessStateName) {
          GlobalFunctions.showSnackBar(context,
              appLocalizations.profile_tabs_preferences_toast_description,
              type: "success");
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
                appLocalizations.profile_tabs_personal_headings_personalInfo,
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
                          title: appLocalizations.profile_tabs_personal_fields_label_firstName,
                          child: AppTextFields.simpleTextField(
                            name: "firstName",
                            hint: appLocalizations.profile_tabs_personal_placeholders_firstName,
                            onChanged: checkFinalValid,
                            extraValidators: [
                              (val) {
                                return (val!.contains(RegExp(r'[0-9]')))
                                    ? "First name cannot be contain numeric characters"
                                    : null;
                              }
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ExpandedIf(
                      expanded: isTablet,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: EachTextField(
                          hasInfo: false,
                          title: appLocalizations.profile_tabs_personal_fields_label_lastName,
                          child: AppTextFields.simpleTextField(
                            name: "lastName",
                            hint: appLocalizations.profile_tabs_personal_placeholders_lastName,
                            onChanged: checkFinalValid,
                            extraValidators: [
                              (val) {
                                return (val!.contains(RegExp(r'[0-9]')))
                                    ? "Last name cannot be contain numeric characters"
                                    : null;
                              }
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  width: isTablet ? 160 : null,
                  child: ElevatedButton(
                    onPressed: !enableSubmitButton
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<PersonalInformationCubit>().setName(
                                  map: formKey.currentState!.instantValue);
                            }
                          },
                    child: Text(appLocalizations.profile_tabs_preferences_button_applyChanges),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
