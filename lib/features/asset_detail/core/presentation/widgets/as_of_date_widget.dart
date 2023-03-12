import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class AsOfDateWidget extends AppStatelessWidget {
  final bool asOf;
  final DateTime shownDate;
  const AsOfDateWidget({
    required this.shownDate,
    this.asOf = false,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(responsiveHelper.biggerGap),
        child: Text(
          "${asOf ? ('(${appLocalizations.assetsOverview_asOf}') : appLocalizations.assets_label_lastUpdatedOn} ${CustomizableDateTime.dmyV2(shownDate, context)}${asOf ? ')':''}",
          style: textTheme.bodySmall,
        ),
      ),
    );
  }
}
