import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsideAssetCardMobile extends AppStatelessWidget {
  const InsideAssetCardMobile({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.link,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Alphabet Inc class A",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Text("North America"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Text("\$1,000,000"),
              Row(
                children: [
                  ChangeWidget(number: 10.0, text: "00.0%"),
                  const SizedBox(width: 8),
                  ChangeWidget(number: -20.0, text: "00.0%"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}