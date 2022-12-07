import 'package:equatable/equatable.dart';

class GetCustodianBankListEntity extends Equatable {
  const GetCustodianBankListEntity({
    required this.bankId,
    required this.bankName,
  });

  final String bankId;
  final String bankName;

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "bankName": bankName,
      };

  @override
  List<Object?> get props => [
        bankId,
        bankName,
      ];
}
