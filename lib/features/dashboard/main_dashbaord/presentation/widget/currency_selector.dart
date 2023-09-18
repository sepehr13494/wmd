import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({super.key});

  @override
  AppState<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends AppState<CurrencySelector> {
  final List items = ['TRY', 'USD'];
  int index = 0;
  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context) {
          return List.generate(
              items.length,
              (i) => PopupMenuItem(
                    child: Text(items[i]),
                    onTap: () async {
                      setState(() {
                        index = i;
                      });
                    },
                  ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              items[index],
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
