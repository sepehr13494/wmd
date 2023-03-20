import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
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
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                'Balances hidden for privacy purposes.',
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
