import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustodianBankStatusEntity extends Equatable {
  const CustodianBankStatusEntity({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.status,
    required this.signLetterLink,
    required this.tutorialLink,
    this.accountNumber,
    this.shareDate,
    this.syncDate,
    this.type,
    this.subType,
  });

  final String id;
  final String bankId;
  final String bankName;
  final CustodianStatus status;
  final String signLetterLink;
  final String tutorialLink;
  final String? accountNumber;
  final DateTime? shareDate;
  final DateTime? syncDate;
  final String? type;
  final String? subType;

  Map<String, dynamic> toJson() => {
        "id": id,
        "bankId": bankId,
        "bankName": bankName,
        "status": status,
        "signLetterLink": signLetterLink,
        "tutorialLink": tutorialLink,
        "accountNumber": accountNumber,
        "shareDate": shareDate,
        "syncDate": syncDate,
        "type": type,
        "subType": subType,
      };

  @override
  List<Object?> get props => [
        id,
        bankId,
        status,
        signLetterLink,
        tutorialLink,
        accountNumber,
        shareDate,
        syncDate,
        type,
        subType,
      ];

  static const tResponse = {
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "bankId": "string",
    "bankName": "string",
    "accountNumber": "string",
    "signLetterLink": "string",
    "tutorialLink": "string",
    "status": "FillAccount",
    "shareDate": "2023-07-27T10:08:43.464Z",
    "syncDate": "2023-07-27T10:08:43.464Z",
    "type": "string",
    "subType": "string"
  };

  String statusText(AppLocalizations appLocalizations) {
    String res = "";

    if (bankId == "ubp") {
      switch (status) {
        case CustodianStatus.ShareLetter:
          res = appLocalizations.home_custodianBankList_swissStatusText_step1;
          break;
        case CustodianStatus.SyncBank:
          res = appLocalizations.home_custodianBankList_swissStatusText_step2;
          break;
        default:
          res = "";
          break;
      }
    } else {
      switch (status) {
        case CustodianStatus.OpenLetter:
          res = appLocalizations.home_custodianBankList_statusText_step1;
          break;
        case CustodianStatus.FillLetter:
          res = appLocalizations.home_custodianBankList_statusText_step2;
          break;
        case CustodianStatus.ShareLetter:
          res = appLocalizations.home_custodianBankList_statusText_step3;
          break;
        case CustodianStatus.SyncBank:
          res = appLocalizations.home_custodianBankList_statusText_step4;
          break;
        case CustodianStatus.FillAccount:
          res = appLocalizations.home_custodianBankList_statusText_step1;
          break;
        default:
          res = "";
          break;
      }
    }

    return res;
  }
}

enum CustodianStatus {
  // ignore: constant_identifier_names
  FillAccount,
  // ignore: constant_identifier_names
  OpenLetter,
  // ignore: constant_identifier_names
  FillLetter,
  // ignore: constant_identifier_names
  ShareLetter,
  // ignore: constant_identifier_names
  SyncBank,
  // ignore: constant_identifier_names
  SyncDone,
}

CustodianStatus getCustodianStatusFromString(String statusAsString) {
  if (statusAsString == "FillAccount") {
    return CustodianStatus.FillAccount;
  } else if (statusAsString == "OpenLetter") {
    return CustodianStatus.OpenLetter;
  } else if (statusAsString == "FillLetter") {
    return CustodianStatus.FillLetter;
  } else if (statusAsString == "ShareLetter") {
    return CustodianStatus.ShareLetter;
  } else if (statusAsString == "SyncBank") {
    return CustodianStatus.SyncBank;
  } else if (statusAsString == "SyncDone") {
    return CustodianStatus.SyncDone;
  } else {
    return CustodianStatus.FillAccount;
  }
}

bool checkCurrentCustodianStatus(
    CustodianStatus status, CustodianStatus currentStatus) {
  return status.index <= currentStatus.index;
}

bool checkCurrentCustodianStatusDone(
    CustodianStatus status, CustodianStatus currentStatus) {
  return status.index < currentStatus.index;
}
