import 'package:flutter/material.dart';

class AppFormValidators {
  static RegExp numReg = RegExp(r".*[0-9].*");
  static RegExp letterReg = RegExp(r".*[A-Za-z].*");
  static RegExp lowerCaseReg = RegExp(r".*[a-z].*");
  static RegExp upperCaseReg = RegExp(r".*[A-Z].*");
  static RegExp specialCharReg = RegExp(r".*[#?!@$%^&*-].*");
  static RegExp lengthCharReg = RegExp(r".{8,}");

  static FormFieldValidator<String?> validatePassword({
    String? errorText,
  }) {
    return (String? valueCandidate) {
      return !(numReg.hasMatch(valueCandidate ?? "") &&
              letterReg.hasMatch(valueCandidate ?? ""))
          ? errorText ?? "wrong password"
          : null;
    };
  }

  static checkNumberValidation(String? value) {
    return numReg.hasMatch(value ?? "");
  }

  static checkLowerCaseValidation(String? value) {
    return lowerCaseReg.hasMatch(value ?? "");
  }

  static checkUpperCaseValidation(String? value) {
    return upperCaseReg.hasMatch(value ?? "");
  }

  static specialCharsValidation(String? value) {
    return specialCharReg.hasMatch(value ?? "");
  }

  static lengthValidation(String? value) {
    return lengthCharReg.hasMatch(value ?? "");
  }
}
