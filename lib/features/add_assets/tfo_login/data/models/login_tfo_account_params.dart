import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/pam_login/data/models/mandate_param.dart';
import 'dart:convert';

class LoginTfoAccountParams extends Equatable {
  final List<Mandate> mandates;
  const LoginTfoAccountParams(this.mandates);

  String toJson() => jsonEncode(mandates);

  @override
  List<Object?> get props => [
        mandates,
      ];

  static final tParams = LoginTfoAccountParams([Mandate(1234, 'Pam')]);
}
