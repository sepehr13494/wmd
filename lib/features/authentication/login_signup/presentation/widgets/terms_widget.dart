import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showTermsModal({
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
        child: TermsWidget(),
        // actionsOverflowButtonSpacing: 0,
      );
    },
  );
}

class TermsWidget extends StatefulWidget {
  const TermsWidget({Key? key}) : super(key: key);

  @override
  AppState<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends AppState<TermsWidget> {
  final ScrollController scrollController = ScrollController();
  bool reachEnd = false;

  @override
  void initState() {
    scrollController.addListener(() async {
      if (!reachEnd) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 0.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          setState(() {
            reachEnd = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
              appLocalizations.auth_signup_tos_title,
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              controller: scrollController,
              child: Center(
                  child: Column(
                children: [
                  Text(appLocalizations.auth_signup_tos_content_mobile),
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: e,
                        ))
                    .toList(),
              )),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: reachEnd
                          ? () {
                              Navigator.pop(context, true);
                            }
                          : null,
                      child: Text(appLocalizations.common_button_acceptAll)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(appLocalizations.common_button_cancel)),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
