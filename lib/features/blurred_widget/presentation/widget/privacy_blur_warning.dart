import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';

import '../../data/models/set_blurred_params.dart';
import '../manager/blurred_privacy_cubit.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balances hidden for privacy purposes.',
                      style: textTheme.bodyLarge,
                    ),
                    if (showCloseButton)
                      InkWell(
                          onTap: () {
                            context.read<BlurredPrivacyCubit>().setBlurred(
                                SetBlurredParams(isBlurred: !isBlurred));
                          },
                          child: Text(
                            "Turn off privacy mode",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: Theme.of(context).primaryColor),
                          )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
