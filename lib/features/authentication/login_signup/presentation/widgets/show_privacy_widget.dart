import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showPrivacyModal({
  required BuildContext context,
}) async {
  return await showDialog<bool?>(
    context: context,
    builder: (context) {
      return const Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: PrivacyWidget(),
        // actionsOverflowButtonSpacing: 0,
      );
    },
  );
}

class PrivacyWidget extends AppStatelessWidget {
  const PrivacyWidget({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Table of Contents',
              // appLocalizations.auth_signup_tos_title,
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(appLocalizations.auth_signup_privacy_mobile),
                ]),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}
