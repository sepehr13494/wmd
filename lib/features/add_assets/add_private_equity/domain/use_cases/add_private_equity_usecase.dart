import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/repositories/private_equity_repository.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddPrivateEquityUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final PrivateEquityRepository privateEquityRepository;
  final LocalStorage localStorage;

  AddPrivateEquityUseCase(this.privateEquityRepository, this.localStorage);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    final ownerId = localStorage.getOwnerId();
    params['owner'] = ownerId;
    final privateEquityParams = AddPrivateEquityParams.fromJson(params);
    return await privateEquityRepository.postPrivateEquity(privateEquityParams);
  }
}

AddPrivateEquityParams addPrivateEquityParamsFromJson(String str) =>
    AddPrivateEquityParams.fromJson(json.decode(str));

String addPrivateEquityParamsToJson(AddPrivateEquityParams data) =>
    json.encode(data.toJson());

class AddPrivateEquityParams {
  const AddPrivateEquityParams({
    this.isActive,
    required this.investmentName,
    required this.country,
    required this.currencyCode,
    required this.investmentAmount,
    required this.marketValue,
    required this.investmentDate,
    required this.valuationDate,
    this.wealthManager,
    required this.owner,
  });

  final bool? isActive;
  final String investmentName;
  final String country;
  final String currencyCode;
  final int investmentAmount;
  final int marketValue;
  final DateTime investmentDate;
  final DateTime valuationDate;
  final String? wealthManager;
  final String owner;

  factory AddPrivateEquityParams.fromJson(Map<String, dynamic> json) =>
      AddPrivateEquityParams(
        isActive: json["isActive"],
        investmentName: json["investmentName"],
        country: json["country"],
        currencyCode: json["currencyCode"],
        investmentAmount: json["investmentAmount"],
        marketValue: json["marketValue"],
        investmentDate: DateTime.parse(json["investmentDate"]),
        valuationDate: DateTime.parse(json["valuationDate"]),
        wealthManager: json["wealthManager"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "investmentName": investmentName,
        "country": country,
        "currencyCode": currencyCode,
        "investmentAmount": investmentAmount,
        "marketValue": marketValue,
        "investmentDate": investmentDate.toIso8601String(),
        "valuationDate": valuationDate.toIso8601String(),
        "wealthManager": wealthManager,
        "owner": owner,
      };

  static const tAddPrivateEquityMap = {
    "isActive": false,
    "investmentName": "Faizan",
    "country": "BH",
    "currencyCode": "USD",
    "investmentAmount": 100000,
    "marketValue": 100000,
    "investmentDate": "2022-10-05T21:00:00.000Z",
    "valuationDate": "2022-10-05T21:00:00.000Z",
    "wealthManager": "Faizan",
    "owner": "ownerId"
  };

  static final tAddPrivateEquityParams = AddPrivateEquityParams(
    investmentName: "investmentName",
    country: "country",
    currencyCode: "currencyCode",
    investmentAmount: 10000,
    marketValue: 10000,
    investmentDate: DateTime.now(),
    valuationDate: DateTime.now(),
    owner: "owner",
  );
}
