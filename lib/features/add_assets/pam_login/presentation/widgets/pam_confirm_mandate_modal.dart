import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

Future<bool> showPamConfirmMandateModal({required BuildContext context}) async {
  final appLocalizations = AppLocalizations.of(context);
  final textTheme = Theme.of(context).textTheme;
  final primaryColor = Theme.of(context).primaryColor;
  final isMobile = ResponsiveHelper(context: context).isMobile;
  return await showDialog(
    context: context,
    builder: (context) {
      final content = CenterModalWidget(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: AppColors.green),
            const SizedBox(height: 16),
            Text(
              'Your TFO account has been successfully linked',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations
                  .common_linkTFO_modal_multipleMandates_description,
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CheckMandate(
                title: 'Mandate title goes here 1', onChange: (val) {}),
            CheckMandate(
              title: 'Mandate title goes here 2',
              onChange: (val) {},
              initialValue: false,
            ),
            CheckMandate(
                title: 'Mandate title goes here 3', onChange: (val) {}),
          ],
        ),
        actions: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
            child: Text(appLocalizations.common_button_continue),
          ),
        ),
      );
      if (isMobile) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 2),
        child: content,
      );
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      return true;
    }
    return false;
  });
}

class CheckMandate extends StatefulWidget {
  final String title;
  final bool initialValue;
  final Function(bool) onChange;
  const CheckMandate({
    Key? key,
    required this.title,
    this.initialValue = true,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CheckMandate> createState() => _CheckMandateState();
}

class _CheckMandateState extends State<CheckMandate> {
  late bool value;
  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  value = val;
                });
                widget.onChange(value);
              }
            }),
        Text(widget.title)
      ],
    );
  }
}
