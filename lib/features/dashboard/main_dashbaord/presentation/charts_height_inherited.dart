import 'package:flutter/material.dart';

class ChartsChildrenCounts extends InheritedWidget {
  const ChartsChildrenCounts({
    super.key,
    required this.length,
    required super.child,
  });

  final int length;

  static ChartsChildrenCounts of(BuildContext context) {
    final ChartsChildrenCounts? result =
        context.dependOnInheritedWidgetOfExactType<ChartsChildrenCounts>();
    assert(result != null, 'No PrivacyInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChartsChildrenCounts oldWidget) {
    return (length > oldWidget.length);
  }
}
