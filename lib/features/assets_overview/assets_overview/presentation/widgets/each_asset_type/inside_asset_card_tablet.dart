import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../parametr_flex.dart';

class InsideAssetCardTablet extends AppStatelessWidget {
  const InsideAssetCardTablet({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final flexList = ParameterFlex.of(context).flexList;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: List.generate(flexList.length, (index) {
          return ExpandedIf(
            expanded: flexList[index] != 0,
            flex: flexList[index],
            child: SizedBox(
              width: flexList[index] == 0
                  ? ParameterFlex.of(context).nonExpandedWidth
                  : null,
              child: Builder(
                builder: (context) {
                  switch (index) {
                    case 0:
                      return Row(
                        children: [
                          const Icon(
                            Icons.link,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Saudi Investment Bank",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      );
                    case 1:
                      return Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("USD 1,000,000"),
                          ),
                        ),
                      );
                    case 2:
                      return ChangeWidget(number: 10.0, text: "10.0%");
                    case 3:
                      return ChangeWidget(number: -10.0, text: "-10.0%");
                    case 4:
                      return Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("North Africa"),
                          ),
                        ),
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
