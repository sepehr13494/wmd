import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';

class PersonalInformationWidget extends AppStatelessWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FormBuilder(
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: EachTextField(
                        title: "First Name",
                        child: AppTextFields.simpleTextField(
                            name: "firstName",
                            hint: "Enter First Name",
                            type: TextFieldType.email),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ExpandedIf(
                    expanded: isTablet,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: EachTextField(
                        title: "Last Name",
                        child: AppTextFields.simpleTextField(
                          name: "lastName",
                          hint: "Enter Last Name",
                          type: TextFieldType.number,
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
                  onPressed: () {},
                  child: Text("Apply Changes"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
