import 'package:flutter/material.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/global_variables.dart';

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
        print("asdfasdf");
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 0.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          print("resid");
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              controller: scrollController,
              child: Center(
                child: Text(
                  "$loroIpsum \n $loroIpsum \n $loroIpsum \n $loroIpsum \n $loroIpsum \n $loroIpsum \n $loroIpsum \n $loroIpsum \n ",
                  style: textTheme.bodyMedium,
                ),
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
    );
  }
}
