import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class AddAssetConstants {
  static final initialJsonForAddAsset = {
    "currencyCode": Currency.currenciesList.first,
    "noOfUnits": "1",
    "units": "1",
    "ownershipPercentage": "100",
    "ownerShip": "100"
  };
  static final initialJsonForAddOtherAsset = {
    "currencyCode": Currency.currenciesList.first,
    "noOfUnits": "1",
    "units": "1",
  };
}
