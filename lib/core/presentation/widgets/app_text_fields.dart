import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/app_form_validators.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';

enum TextFieldType{
  email,
  password,
  phone,
  simpleText,
}
class AppTextFields {
  AppTextFields._();

  static FormBuilderTextField simpleTextField({
    required String name,
    TextFieldType type = TextFieldType.simpleText,
    String? title,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int? minLines,
    bool enabled = true,
    bool obscureText = false,
    Widget? suffixIcon,
    bool required = true,
  }) {
    final validators = <String? Function(String?)>[];
    if(required){
      validators.add(FormBuilderValidators.required());
    }
    switch (type){

      case TextFieldType.email:
        validators.add(FormBuilderValidators.email());
        break;
      case TextFieldType.password:
        validators.add(FormBuilderValidators.minLength(8));
        validators.add(AppFormValidators.validatePassword());
        break;
      case TextFieldType.phone:
        break;
      case TextFieldType.simpleText:
        break;
    }
    return FormBuilderTextField(
      name: name,
      minLines: minLines ?? 1,
      maxLines: (type == TextFieldType.password) ? 1 : 5,
      enabled: enabled,
      decoration: InputDecoration(
          labelText: title, hintText: hint, suffixIcon: suffixIcon),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      autofillHints: _getAutofillHint(type) == null ? null : [_getAutofillHint(type)!],
      validator: FormBuilderValidators.compose(validators),
    );
  }

  static String? _getAutofillHint(TextFieldType type) {
    switch (type) {
      case TextFieldType.email:
        return AutofillHints.email;
      case TextFieldType.password:
        return AutofillHints.password;
      case TextFieldType.phone:
        return AutofillHints.telephoneNumber;
      case TextFieldType.simpleText:
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
      type: TextFieldType.password,
      hint: appLocalizations.sign_up_password_placeholder,
      obscureText: !visible,
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
