import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/currency/presentation/manager/currency_cubit.dart';

class YourHoldingsWidget extends AppStatelessWidget {
  final double holdings;
  final double localCurrencyValue;
  final String currencyCode;

  const YourHoldingsWidget({
    required this.holdings,
    required this.localCurrencyValue,
    required this.currencyCode,
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return BlocConsumer<CurrencyCubit, CurrencyState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.assets_label_yourHoldings,
                style: textTheme.titleSmall?.apply(fontSizeDelta: 1.28),
              ),
              SizedBox(height: responsiveHelper.biggerGap),
              PrivacyBlurWidget(
                child: Text(
                  holdings.convertMoney(addDollar: true),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: responsiveHelper.biggerGap),
              if (currencyCode != "USD")
                PrivacyBlurWidget(
                  child: Text(
                    "$currencyCode ${localCurrencyValue.convertMoney(addDollar: false)}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              SizedBox(height: responsiveHelper.biggerGap),
              if (currencyCode != "USD")
                Row(
                  mainAxisAlignment: responsiveHelper.isMobile
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (state is GetCurrencyConversionLoaded)
                      Text(
                        "1 USD = ${(1 / state.getCurrencyEntity.conversionRate).formatNumberTwoDecimal} $currencyCode ${appLocalizations.common_labels_asOf} ${CustomizableDateTime.dmyV2(state.getCurrencyEntity.date, context)}",
                        style: textTheme.bodySmall,
                      )
                  ],
                )
            ],
          );
        });
  }
}
