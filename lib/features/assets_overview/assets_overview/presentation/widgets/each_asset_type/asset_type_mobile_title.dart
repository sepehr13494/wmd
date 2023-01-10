import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssetTypeMobileTableTitle extends AppStatelessWidget {
  const AssetTypeMobileTableTitle({super.key});

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    List<String> items = [
      appLocalizations.assets_table_header_asset,
      appLocalizations.assets_table_header_valueItdYtd,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(items.length, (index) {
        return Text(items[index],style: textTheme.bodySmall,);
      }),
    );
  }
}