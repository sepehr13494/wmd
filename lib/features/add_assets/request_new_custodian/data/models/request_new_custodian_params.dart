import 'package:equatable/equatable.dart';

class RequestNewCustodianParams extends Equatable {
  final String accountNumber;
  final String bankName;
  final String country;
  final String rmName;
  final String rmEmail;
  final String userEmail;
  final bool consent;
  const RequestNewCustodianParams(
      {required this.accountNumber,
      required this.bankName,
      required this.country,
      required this.rmName,
      required this.consent,
      required this.userEmail,
      required this.rmEmail});

  factory RequestNewCustodianParams.fromJson(
          Map<String, dynamic> json, String useremail) =>
      RequestNewCustodianParams(
        accountNumber: json['accountNumber'],
        bankName: json['bankName'],
        country: json['country'],
        rmName: json['rmName'],
        rmEmail: json['rmEmail'],
        userEmail: useremail,
        consent: json['consent'],
      );

  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'bankName': bankName,
        'country': country,
        'rmName': rmName,
        'userEmail': userEmail,
        'rmEmail': rmEmail,
        'consent': consent,
      };

  @override
  List<Object?> get props => [];

  static const tParams = RequestNewCustodianParams(
    accountNumber: 'ba',
    bankName: 'bn',
    country: 'c',
    userEmail: 'c',
    rmEmail: 'rE',
    consent: true,
    rmName: 'rN',
  );
}
