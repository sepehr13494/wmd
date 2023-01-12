import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';

import '../manager/main_dashboard_cubit.dart';

class SummaryTimeFilter extends AppStatelessWidget {
  const SummaryTimeFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocConsumer<MainDashboardCubit, MainDashboardState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: (context, state) {
          return Row(
            children: [
              Text(appLocalizations.home_subheading,
                  style: textTheme.titleLarge),
              const Spacer(),
              Icon(
                Icons.calendar_month,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              DropdownButtonHideUnderline(
                child: DropdownButton<TimeFilterObj>(
                  items: AppConstants.timeFilter(context)
                      .map((e) => DropdownMenuItem<TimeFilterObj>(
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
                      context
                          .read<DashboardAllocationCubit>()
                          .getAllocation(dateTime: value);
                      context.read<ChartsCubit>().getChart(dateTime: value);
                    }
                  }),
                  value: context.read<MainDashboardCubit>().dateTimeRange ??
                      AppConstants.timeFilter(context).first,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                  // style: textTheme.labelLarge,
                ),
              ),
            ],
          );
        });
  }
}
