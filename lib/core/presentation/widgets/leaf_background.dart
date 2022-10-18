import 'package:flutter/material.dart';

class LeafBackground extends StatelessWidget {
  final double opacity;
  const LeafBackground({
    Key? key, this.opacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
        return LinearGradient(
          colors: [bgColor.withOpacity(opacity), bgColor.withOpacity(opacity)],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Image.asset(
        "assets/images/auth_background_image.png",
        width: double.maxFinite,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
