import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/currency/data/models/currencies.dart';
import 'package:wmd/features/currency/presentation/manager/currency_cubit.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({super.key});

  @override
  AppState<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends AppState<CurrencySelector> {
  int index = 0;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final cubit = context.read<CurrencyCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context) {
          return List.generate(
              Currencies.currencies.length,
              (i) => PopupMenuItem(
                    child: Text(Currencies.currencies[i]),
                    onTap: () async {
                      setState(() {
                        index = i;
                      });
                      cubit.getCurrency(
                          Currencies.USD, Currencies.currencies[index]);
                    },
                  ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Currencies.currencies[index],
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
