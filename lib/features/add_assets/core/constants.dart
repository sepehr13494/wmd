import 'package:flutter/material.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class AddAssetConstants {
  static initialJsonForAddAsset(BuildContext context) => {
    "currencyCode": Currency.getCurrencyList(context).first,
    "noOfUnits": "1",
    "units": "1",
    "ownershipPercentage": "100",
    "ownerShip": "100"
  };
  static initialJsonForAddOtherAsset(BuildContext context) => {
    "currencyCode": Currency.getCurrencyList(context).first,
    "noOfUnits": "1",
    "units": "1",
  };
}
