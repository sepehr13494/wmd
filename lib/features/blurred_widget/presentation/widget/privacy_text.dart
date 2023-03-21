import 'package:flutter/material.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:blur/blur.dart';

class PrivacyBlurWidget extends StatelessWidget {
  final Widget child;
  const PrivacyBlurWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;

    return Blur(
      blur: isBlurred ? 6 : 0,
      borderRadius: BorderRadius.circular(5),
      colorOpacity: 0,
      child: child,
    );
  }
}