import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/custom_icons.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

class PrivacyBlurWarning extends AppStatelessWidget {
  final bool showCloseButton;
  const PrivacyBlurWarning({super.key, this.showCloseButton = true});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    bool isBlurred = PrivacyInherited.of(context).isBlurred;
    if (!isBlurred) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: AppColors.blueCardColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                CustomIcons.privacy_blur_icon,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizations.profile_tabs_preferences_privacyMode_warning,
                style: textTheme.bodyLarge,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
