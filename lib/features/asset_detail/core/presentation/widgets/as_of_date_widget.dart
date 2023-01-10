import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class AsOfDateWidget extends AppStatelessWidget {
  final DateTime shownDate;
  const AsOfDateWidget({
    required this.shownDate,
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
          "${appLocalizations.assets_label_lastUpdatedOn} ${CustomizableDateTime.dateLocalized(shownDate)}",
          style: textTheme.bodySmall,
        ),
      ),
    );
  }
}
