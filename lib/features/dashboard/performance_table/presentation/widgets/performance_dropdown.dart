import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';

import '../manager/performance_table_cubit.dart';

class PerformanceDropdown extends AppStatelessWidget {
  final PerformanceTableCubit bloc;
  final Function(TimeFilterObj) function;
  final List<TimeFilterObj>? customItems;
  const PerformanceDropdown({Key? key, required this.bloc, required this.function, this.customItems}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    final items = customItems ?? AppConstants.timeFilterForAssetPerformance(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<TimeFilterObj>(
        items: items
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
            function(value);
          }
        }),
        value: bloc.period ?? items.first,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 15,
          color: Theme.of(context).primaryColor,
        ),
        // style: textTheme.labelLarge,
      ),
    );
  }
}
