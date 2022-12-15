import 'package:equatable/equatable.dart';

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
}
