import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusEntity extends Equatable {
  const StatusEntity({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.signLetter,
    required this.signLetterLink,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String id;
  final String bankId;
  final String bankName;
  final bool signLetter;
  final String signLetterLink;
  final bool shareWithBank;
  final bool bankConfirmation;

  Map<String, dynamic> toJson() => {
        "id": id,
        "bankId": bankId,
        "bankName": bankName,
      };

  @override
  List<Object?> get props => [
        id,
        bankId,
        bankName,
        signLetter,
        signLetterLink,
        shareWithBank,
        bankConfirmation,
      ];

  String statusText(AppLocalizations appLocalizations) {
    if (shareWithBank && signLetter && !bankConfirmation) {
      return 'Awating confirmation from the bank';
    } else if (signLetter && !shareWithBank) {
      return 'Waiting for you to share with the bank';
    }
    return 'Download and sign the letter';
  }
}
