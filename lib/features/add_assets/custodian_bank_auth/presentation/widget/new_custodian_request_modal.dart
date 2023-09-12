import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';

Future<void> showNewCustodianModal({
  required BuildContext context,
}) async {
  final appLocalization = AppLocalizations.of(context);
  return await showDialog(
    context: context,
    builder: (context) {
      return const CenterModalWidget(
        body: RequestCustodianForm(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        actions: SizedBox(),
      );
    },
  );
}

class RequestCustodianForm extends AppStatelessWidget {
  const RequestCustodianForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final _formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: _formKey,
      onChanged: () {
        _formKey.currentState!.save();
        debugPrint(_formKey.currentState!.value.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                appLocalizations.common_newCustodianRequest_modal_title,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(appLocalizations.common_newCustodianRequest_modal_bankDetails),
            const SizedBox(height: 8),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'accountNumber',
              decoration: InputDecoration(
                labelText: appLocalizations
                    .common_newCustodianRequest_modal_accountNumber,
                filled: true,
                fillColor: AppColors.bgColor,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'bankName',
              decoration: InputDecoration(
                labelText:
                    appLocalizations.common_newCustodianRequest_modal_bankName,
                filled: true,
                fillColor: AppColors.bgColor,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'bankCountry',
              decoration: InputDecoration(
                labelText: appLocalizations
                    .common_newCustodianRequest_modal_bankCountry,
                filled: true,
                fillColor: AppColors.bgColor,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            Text(appLocalizations
                .common_newCustodianRequest_modal_managerDetails),
            const SizedBox(height: 8),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'managerName',
              decoration: InputDecoration(
                labelText: appLocalizations
                    .common_newCustodianRequest_modal_managerName,
                filled: true,
                fillColor: AppColors.bgColor,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'managerEmail',
              decoration: InputDecoration(
                labelText: appLocalizations
                    .common_newCustodianRequest_modal_managerEmail,
                filled: true,
                fillColor: AppColors.bgColor,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 24),
            Card(
              color: AppColors.blueCardColor,
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (val) {},
                    ),
                    Expanded(
                      child: Text(
                        appLocalizations.common_newCustodianRequest_modal_check,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(appLocalizations.common_button_submit),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
