import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class UnsafeDevicePage extends AppStatelessWidget {
  const UnsafeDevicePage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Builder(builder: (context) {
                late final String term;
                if (Platform.isAndroid) {
                  term = 'rooted';
                } else if (Platform.isIOS) {
                  term = 'jailbroken';
                } else {
                  term = 'not safe';
                }
                return Text(
                  'The device that you are using is $term. Please make sure you device is safe before using',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  ShaderMask _buildBackground(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
        return LinearGradient(
          colors: [bgColor.withOpacity(0.9), bgColor.withOpacity(0.9)],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: LayoutBuilder(builder: (context, snapShot) {
        return Center(
          child: SvgPicture.asset(
            "assets/images/logo_splash.svg",
            width: snapShot.maxWidth * 0.7,
          ),
        );
      }),
    );
  }
}
