import 'package:flutter/material.dart';

class PrivacyInherited extends InheritedWidget {
  const PrivacyInherited({
    super.key,
    this.isBlurred = false,
    required super.child,
  });

  final bool isBlurred;

  static PrivacyInherited of(BuildContext context) {
    final PrivacyInherited? result =
        context.dependOnInheritedWidgetOfExactType<PrivacyInherited>();
    assert(result != null, 'No PrivacyInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PrivacyInherited oldWidget) {
    return (isBlurred != oldWidget.isBlurred);
  }
}

class PrivacyText extends StatefulWidget {
  const PrivacyText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
  });

  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;

  @override
  State<PrivacyText> createState() => PrivacyTextState();
}

class PrivacyTextState extends State<PrivacyText> {
  @override
  Widget build(BuildContext context) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    return Text(
      isBlurred ? '****' : widget.data,
      textAlign: widget.textAlign,
      strutStyle: widget.strutStyle,
      style: widget.style,
    );
  }
}
