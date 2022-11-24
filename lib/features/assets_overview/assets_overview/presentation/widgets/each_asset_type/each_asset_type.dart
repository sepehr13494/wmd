import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/dot_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/parametr_flex.dart';

import '../add_button.dart';
import '../ytd_itd_widget.dart';
import 'asset_type_base_card.dart';
import 'asset_type_mobile_title.dart';
import 'asset_type_tablet_title.dart';

class EachAssetType extends AppStatelessWidget {
  const EachAssetType({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;
    return Column(
      children: [
        Row(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        DotWidget(color: Colors.purple.shade200),
                        const SizedBox(width: 8),
                        Text("Bank account", style: textTheme.titleSmall)
                      ],
                    ),
                  ),
                ),
                RowOrColumn(
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  showRow: !isMobile,
                  children: [
                    Text(
                      "\$5,000,000",
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(width: responsiveHelper.bigger16Gap, height: 16),
                    YtdItdWidget(),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: AddButton(onTap: () {}, addAsset: true),
            ),
          ],
        ),
        ParameterFlex(
          child: Builder(builder: (context) {
            ExpandableController controller = ExpandableController();
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12,bottom: 4,right: 4,left: 4),
                  child: ResponsiveWidget(
                    mobile: AssetTypeMobileTableTitle(),
                    tablet: AssetTypeTabletTableTitle(),
                    desktop: AssetTypeTabletTableTitle(),
                  ),
                ),
                ExpandablePanel(
                  collapsed: AssetTypeBaseCard(
                      count: 2, showMore: false, controller: controller),
                  expanded: AssetTypeBaseCard(
                      count: 5, showMore: true, controller: controller),
                  controller: controller,
                )
              ],
            );
          }),
        )
      ],
    );
  }
}
