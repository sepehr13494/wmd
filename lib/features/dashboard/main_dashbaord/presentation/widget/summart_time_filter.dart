import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';

import '../manager/main_dashboard_cubit.dart';

class SummaryTimeFilter extends AppStatelessWidget {
  const SummaryTimeFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Row(
      children: [
        Text(appLocalizations.home_subheading, style: textTheme.titleLarge),
        const Spacer(),
        Icon(
          Icons.calendar_month,
          size: 15,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        DropdownButton<MapEntry<String, int>>(
          items: AppConstants.timeFilter
              .map((e) => DropdownMenuItem<MapEntry<String, int>>(
                  value: e,
                  child: Text(
                    e.key,
                    style: textTheme.bodyMedium!
                        .apply(color: Theme.of(context).primaryColor),
                    // textTheme.bodyMedium!.toLinkStyle(context),
                  )))
              .toList(),
          onChanged: ((value) {
            if (value != null) {
              context
                  .read<MainDashboardCubit>()
                  .getNetWorth(dateTimeRange: value);
            }
          }),
          value: context.read<MainDashboardCubit>().dateTimeRange,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 15,
            color: Theme.of(context).primaryColor,
          ),
          // style: textTheme.labelLarge,
        ),
      ],
    );
  }
}
