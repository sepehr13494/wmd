import 'package:equatable/equatable.dart';

class GetCustodianBankStatusParams extends Equatable {
  final String bankId;
  final String? custodianBankStatusId;
  const GetCustodianBankStatusParams({
    required this.bankId,
    required this.custodianBankStatusId,
  });

  factory GetCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusParams(
        bankId: json['bankId'],
        custodianBankStatusId: json['custodianBankStatusId'],
      );

  Map<String, dynamic> toJson() => {
        'bankId': bankId,
        if (custodianBankStatusId != null)
          'custodianBankStatusId': custodianBankStatusId,
      };

  @override
  List<Object?> get props => [bankId];
}
