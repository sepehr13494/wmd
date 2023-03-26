import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/custom_icons.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

class TwoFactorRecommendationWidget extends AppStatelessWidget {
  const TwoFactorRecommendationWidget({super.key});

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
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shield,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        appLocalizations.home_twoFactorRecommendation_title,
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        appLocalizations
                            .home_twoFactorRecommendation_description,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(appLocalizations.home_twoFactorRecommendation_btn),
                      const SizedBox(width: 8),
                      const Icon(Icons.turn_right),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
