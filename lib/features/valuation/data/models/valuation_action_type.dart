import 'package:wmd/core/models/radio_button_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValuationActionType {
  final RadioButtonOptions<bool> list;

  ValuationActionType({required this.list});

  static json(context) => [
        RadioButtonOptions(
            label:
                AppLocalizations.of(context).assets_valuationModal_labels_Buy,
            value: "Buy"),
        RadioButtonOptions(
            label:
                AppLocalizations.of(context).assets_valuationModal_labels_Sell,
            value: "Sell"),
        // RadioButtonOptions(
        //     label: AppLocalizations.of(context)
        //         .assets_valuationModal_labels_IncomeCapitalDistribution,
        //     value: "Income / Capital Distribution"),
      ];

  static jsonSell(context) => [
        RadioButtonOptions(
            label:
                AppLocalizations.of(context).assets_valuationModal_labels_Sell,
            value: "Sell"),
      ];

  static valuationActionTypeList(context) => json(context);
  static valuationActionTypeListRealEstate(context) => jsonSell(context);
}
