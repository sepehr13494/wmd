import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusEntity extends Equatable {
  const StatusEntity({
    this.id,
    required this.bankId,
    required this.bankName,
    this.accountId,
    required this.signLetter,
    required this.signLetterLink,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String? id;
  final String bankId;
  final String bankName;
  final String? accountId;
  final bool signLetter;
  final String signLetterLink;
  final bool shareWithBank;
  final bool bankConfirmation;

  @override
  List<Object?> get props => [
        id,
        bankId,
        bankName,
        accountId,
        signLetter,
        signLetterLink,
        shareWithBank,
        bankConfirmation,
      ];

  String statusText(AppLocalizations appLocalizations) {
    if (shareWithBank && signLetter && !bankConfirmation) {
      return appLocalizations.home_custodianBankList_statusText_shareWithBank;
    } else if (signLetter && !shareWithBank) {
      return appLocalizations.home_custodianBankList_statusText_signLetter;
    }
    return appLocalizations.home_custodianBankList_statusText_signLetter;
  }
}
