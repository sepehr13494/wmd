import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'mandate_param.dart';

class LoginPamAccountParams extends Equatable {
  final List<Mandate> mandates;
  const LoginPamAccountParams(this.mandates);

  String toJson() => jsonEncode(mandates);

  @override
  List<Object?> get props => [
        mandates,
      ];

  static final tParams = LoginPamAccountParams([Mandate(1234, 'Pam')]);
}
