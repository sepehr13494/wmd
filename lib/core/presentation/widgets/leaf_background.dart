import 'package:flutter/material.dart';

class LeafBackground extends StatelessWidget {
  const LeafBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
        return LinearGradient(
          colors: [bgColor.withOpacity(.5), bgColor.withOpacity(.5)],
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
