import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class LinkedAccountsPage extends AppStatelessWidget {
  const LinkedAccountsPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.profile_tabs_linkedAccounts_name,
                style: textTheme.headlineSmall,
              ),
              Text('Filter')
            ],
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text('Link new account'),
          ),
        ],
      ),
    );
  }
}
