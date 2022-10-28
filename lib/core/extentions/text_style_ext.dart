import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle toLinkStyle(BuildContext context,) {
    return copyWith(
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.underline);
  }
}
