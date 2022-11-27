import 'package:flutter/material.dart';

class ParameterFlex extends InheritedWidget {
  const ParameterFlex({
    super.key,
    this.flexList = const [6, 4, 0, 0, 3],
    this.nonExpandedWidth = 80,
    required super.child,
  });

  final List<int> flexList;
  final double nonExpandedWidth;

  static ParameterFlex of(BuildContext context) {
    final ParameterFlex? result = context.dependOnInheritedWidgetOfExactType<ParameterFlex>();
    assert(result != null, 'No ParameterFlex found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ParameterFlex old) {
    return (flexList != old.flexList || nonExpandedWidth != old.nonExpandedWidth);
  }
}