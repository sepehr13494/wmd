import 'package:equatable/equatable.dart';

class PostCustodianBankStatusParams extends Equatable {
  const PostCustodianBankStatusParams({
    required this.bankId,
    required this.signLetter,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String bankId;
  final bool signLetter;
  final bool shareWithBank;
  final bool bankConfirmation;

  factory PostCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      PostCustodianBankStatusParams(
        bankId: json["bankId"],
        signLetter: json["signLetter"],
        shareWithBank: json["shareWithBank"],
        bankConfirmation: json["bankConfirmation"],
      );

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "signLetter": signLetter,
        "shareWithBank": shareWithBank,
        "bankConfirmation": bankConfirmation,
      };

  @override
  List<Object?> get props => [
        bankId,
        signLetter,
        shareWithBank,
        bankConfirmation,
      ];
}
