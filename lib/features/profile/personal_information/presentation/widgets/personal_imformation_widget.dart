import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/injection_container.dart';

class PersonalInformationWidget extends AppStatelessWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;
    final formKey = GlobalKey<FormBuilderState>();
    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: (context,state){
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
                "Personal information",
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8),
                        child: EachTextField(
                          title: "First Name",
                          child: AppTextFields.simpleTextField(
                            name: "firstName",
                            hint: "Enter First Name",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ExpandedIf(
                      expanded: isTablet,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8),
                        child: EachTextField(
                          title: "Last Name",
                          child: AppTextFields.simpleTextField(
                            name: "lastName",
                            hint: "Enter Last Name",
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
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        context.read<PersonalInformationCubit>().setName(map: formKey.currentState!.instantValue);
                      }
                    },
                    child: Text("Apply Changes"),
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
