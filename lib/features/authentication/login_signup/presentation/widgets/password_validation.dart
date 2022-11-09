import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordValidation extends StatelessWidget {
  final bool lowercase, uppercase, numbers, special, length;

  const PasswordValidation({
    super.key,
    required this.lowercase,
    required this.uppercase,
    required this.numbers,
    required this.special,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return _passwordValidation(context);
  }

  Widget _passwordValidation(BuildContext context) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Container(
        padding: EdgeInsets.symmetric(
            vertical: responsiveHelper.bigger16Gap, horizontal: 15.0),
        decoration: BoxDecoration(
            color: textTheme.bodySmall!.color!.withOpacity(0.05),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.auth_change_validation_heading,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _validationItem(
                context,
                appLocalizations.auth_signup_input_validation_lowercase,
                lowercase),
            const SizedBox(height: 10),
            _validationItem(
                context,
                appLocalizations.auth_signup_input_validation_uppercase,
                uppercase),
            const SizedBox(height: 10),
            _validationItem(context,
                appLocalizations.auth_signup_input_validation_numbers, numbers),
            const SizedBox(height: 10),
            _validationItem(context,
                appLocalizations.auth_signup_input_validation_special, special),
            const SizedBox(height: 10),
            _validationItem(context,
                appLocalizations.auth_signup_input_validation_length, length),
            const SizedBox(height: 10),
          ],
        ));
  }

  Widget _validationItem(BuildContext context, String label, bool isCorrect) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(microseconds: 500),
          width: 20,
          height: 20,
          child: Icon(isCorrect ? Icons.check_circle : Icons.cancel_rounded,
              color: isCorrect ? Colors.green[400] : Colors.red[700]),
        ),
        SizedBox(width: responsiveHelper.defaultGap),
        Text(
          label,
          style: textTheme.bodySmall,
        )
      ],
    );
  }
}
