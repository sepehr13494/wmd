import 'package:equatable/equatable.dart';

class RequestNewCustodianParams extends Equatable {
  final String accountNumber;
  final String bankName;
  final String country;
  final String rmName;
  final String rmEmail;
  const RequestNewCustodianParams(
      {required this.accountNumber,
      required this.bankName,
      required this.country,
      required this.rmName,
      required this.rmEmail});

  factory RequestNewCustodianParams.fromJson(Map<String, dynamic> json) =>
      RequestNewCustodianParams(
        accountNumber: json['accountNumber'],
        bankName: json['bankName'],
        country: json['country'],
        rmName: json['rmName'],
        rmEmail: json['rmEmail'],
      );

  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'bankName': bankName,
        'country': country,
        'rmName': rmName,
        'rmEmail': rmEmail,
      };

  @override
  List<Object?> get props => [];

  static const tParams = RequestNewCustodianParams(
      accountNumber: 'ba',
      bankName: 'bn',
      country: 'c',
      rmEmail: 'rE',
      rmName: 'rN');
}
