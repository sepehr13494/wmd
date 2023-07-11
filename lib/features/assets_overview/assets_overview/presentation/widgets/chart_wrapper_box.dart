import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

class ChartWrapperBox extends StatelessWidget {
  final Widget child;
  const ChartWrapperBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:
      ResponsiveHelper(context: context).isMobile ? 1 : 1.6,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper(context: context)
                .biggerGap),
        child: Card(
          color: Theme.of(context).brightness ==
              Brightness.dark
              ? AppColors.darkCardColorForDarkTheme
              : AppColors.darkCardColorForLightTheme,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
