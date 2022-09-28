import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';

class AppTextFields {
  AppTextFields._();

  static FormBuilderTextField simpleTextField({
    required String name,
    String? title,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int? minLines,
    bool enabled = true,
    bool password = false,
    Widget? suffixIcon,
  }) {
    return FormBuilderTextField(
      name: name,
      minLines: minLines ?? 1,
      maxLines: password ? 1 : 5,
      enabled: enabled,
      decoration: InputDecoration(
          labelText: title, hintText: hint, suffixIcon: suffixIcon),
      obscureText: password,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      autofillHints:
          _getAutofillHint(name) == null ? null : [_getAutofillHint(name)!],
      validator: FormBuilderValidators.required(),
    );
  }

  static String? _getAutofillHint(String name) {
    switch (name) {
      case "email":
        return AutofillHints.email;
      case "password":
        return AutofillHints.password;
      default:
        return null;
    }
  }

  static FormBuilderDropdown dropDownTextField({
    required String title,
    required List<DropdownMenuItem> items,
    bool enabled = true,
  }) {
    return FormBuilderDropdown(
      name: title,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: title,
      ),
      items: items,
      validator: FormBuilderValidators.required(),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  AppState<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends AppState<PasswordTextField> {
  bool visible = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return AppTextFields.simpleTextField(
      name: "password",
      hint: appLocalizations.sign_up_password_placeholder,
      password: !visible,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            visible = !visible;
          });
        },
        icon: Icon(
            visible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,color: Theme.of(context).primaryColor,),
      ),
    );
  }
}
