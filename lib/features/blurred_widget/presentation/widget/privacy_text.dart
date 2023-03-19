import 'package:flutter/material.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:blur/blur.dart';

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

    return Blur(
      blur: isBlurred ? 5 : 0,
      colorOpacity: 0,
      child: Text(
        widget.data,
        textAlign: widget.textAlign,
        strutStyle: widget.strutStyle,
        style: widget.style,
      ),
    );
  }
}
