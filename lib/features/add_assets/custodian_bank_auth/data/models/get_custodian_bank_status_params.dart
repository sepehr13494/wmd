import 'package:equatable/equatable.dart';

class GetCustodianBankStatusParams extends Equatable {
  final String bankId;
  const GetCustodianBankStatusParams({required this.bankId});

  factory GetCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusParams(bankId: json['bankId']);

  Map<String, dynamic> toJson() => {'bankId': bankId};

  @override
  List<Object?> get props => [bankId];
}
