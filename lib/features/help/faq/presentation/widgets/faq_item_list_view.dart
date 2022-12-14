import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';

class FaqItemList extends StatefulWidget {
  const FaqItemList({Key? key}) : super(key: key);

  @override
  AppState<FaqItemList> createState() => _FaqItemListState();
}

class _FaqItemListState extends AppState<FaqItemList> {
  List<bool> expanded = [false, false];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            expanded[panelIndex] = !isExpanded;
          });
        },
        animationDuration: Duration(seconds: 2),
        //animation duration while expanding/collapsing
        children: [
          ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor: AppColors.backgroundColorPageDark,
              headerBuilder: (context, isOpen) {
                return Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Who is the family office?",
                    ));
              },
              body: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Text(
                  "The Family Office is a wealth management firm serving investors, individuals, and families in the Gulf Cooperation Council states since 2004. The Family Office operates in Bahrain and Saudi Arabia and manages \$2 billion in tailored portfolio solutions. In 2020, The Family Office has transferred its international subsidiaries in Hong Kong and New York to Petiole Asset Management (AG) in Zürich, who have assumed the asset management activities of The Family Office.",
                  style: textTheme.bodySmall,
                ),
              ),
              isExpanded: expanded[0]),
          ExpansionPanel(
              backgroundColor: AppColors.backgroundColorPageDark,
              headerBuilder: (context, isOpen) {
                return Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Who is the family office?",
                    ));
              },
              body: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Text(
                  "The Family Office is a wealth management firm serving investors, individuals, and families in the Gulf Cooperation Council states since 2004. The Family Office operates in Bahrain and Saudi Arabia and manages \$2 billion in tailored portfolio solutions. In 2020, The Family Office has transferred its international subsidiaries in Hong Kong and New York to Petiole Asset Management (AG) in Zürich, who have assumed the asset management activities of The Family Office.",
                  style: textTheme.bodySmall,
                ),
              ),
              isExpanded: expanded[0]),
        ]);
  }
}
