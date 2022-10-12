import 'package:flutter/material.dart';

class AppFormValidators{
  static FormFieldValidator<String?> validatePassword({
        String? errorText,
      }) {
    return (String? valueCandidate) {
      RegExp numReg = RegExp(r".*[0-9].*");
      RegExp letterReg = RegExp(r".*[A-Za-z].*");
      return !(numReg.hasMatch(valueCandidate??"") && letterReg.hasMatch(valueCandidate??""))
          ? errorText ??
          "wrong password"
          : null;
    };
  }
}