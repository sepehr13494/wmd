import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class BankAccountDetailPage extends AppStatelessWidget {
  final String id;
  const BankAccountDetailPage({super.key, required this.id});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Container(
      child: Text(id),
    );
  }
}
