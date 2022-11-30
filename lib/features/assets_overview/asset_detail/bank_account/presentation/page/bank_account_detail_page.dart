import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

class BankAccountDetailPage extends AppStatelessWidget {
  final AssetList asset;
  const BankAccountDetailPage({Key? key, required this.asset})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank account details'),
      ),
      body: Container(),
    );
  }
}
