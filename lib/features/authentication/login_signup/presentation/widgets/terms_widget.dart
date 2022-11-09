import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';

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
        appBar: const CustomAuthAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppLogoWidget(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Text(appLocalizations.auth_signup_tos_title,style: textTheme.headlineSmall,),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                controller: scrollController,
                child: Center(
                  child: Column(
                    children: [
                      Text(appLocalizations.auth_signup_tos_content),
                    ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8),child: e,)).toList(),
                  )
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("cancel")),
                  const Spacer(),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: reachEnd
                            ? () {
                                Navigator.pop(context, true);
                              }
                            : null,
                        child: Text("Accept All")),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
