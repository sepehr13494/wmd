import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
  }) {
    return FormBuilderTextField(
      name: name,
      minLines: minLines??1,
      maxLines: password ? 1 : 5,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: title,
        hintText: hint,
      ),
      obscureText: password,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: FormBuilderValidators.required(),
    );
  }

  static FormBuilderDropdown dropDownTextField(
      {required String title, required List<DropdownMenuItem> items,bool enabled = true,}) {
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
