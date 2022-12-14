import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class CurrentDateWidget extends AppStatelessWidget {
  const CurrentDateWidget({
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
          'As of ${CustomizableDateTime.currentDateLocalized}',
          style: textTheme.bodySmall,
        ),
      ),
    );
  }
}
