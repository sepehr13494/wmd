import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/features/authentication/domain/repositories/auth_repository.dart';
import 'dart:convert';

class PostRegisterUseCase extends UseCase<AppSuccess, RegisterParams> {
  final AuthRepository authRepository;

  PostRegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(RegisterParams params) =>
      authRepository.register(params);
}

// class RegisterParams extends Equatable {
//   final String email;
//   final String password;

//   const RegisterParams({
//     this.email = "",
//     this.password = "",
//   });

//   Map<String, dynamic> toJson() => {
//         "email": email,
//         "password": password,
//       };

//   factory RegisterParams.fromJson(Map<String, dynamic> json) {
//     return RegisterParams(
//       email: json['email'],
//       password: json['password'],
//     );
//   }

//   @override
//   List<Object?> get props => [email, password];
// }

// To parse this JSON data, do
//
//     final registerParams = registerParamsFromJson(jsonString);

RegisterParams registerParamsFromJson(String str) =>
    RegisterParams.fromJson(json.decode(str));

String registerParamsToJson(RegisterParams data) => json.encode(data.toJson());

class RegisterParams extends Equatable {
  final String email;
  final String password;
  TermsOfService? termsOfService;
  RegisterParams({
    required this.email,
    required this.password,
    this.termsOfService,
  });

  // static final tRegisterParams =

  static final tTermsOfService = TermsOfService(
    agreedAt: CustomizableDateTime.current.toString(),
    ipAddress: AppDeviceInfo.tAppDeviceInfo.ip,
    userAgent: AppDeviceInfo.tAppDeviceInfo.deviceName,
  );

  static final tRegisterParams = RegisterParams(
      email: 'test@yopmail.com',
      password: 'Passw0rd',
      termsOfService: tTermsOfService);

  static final Map<String, dynamic> map = {
    "email": 'test@yopmail.com',
    "password": 'Passw0rd',
  };

  factory RegisterParams.fromJson(Map<String, dynamic> json) => RegisterParams(
        email: json["email"],
        password: json["password"],
        termsOfService: json["termsOfService"] == null
            ? null
            : TermsOfService.fromJson(json["termsOfService"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "termsOfService": termsOfService?.toJson(),
      };

  @override
  List<Object?> get props => [email, password, termsOfService];
}

class TermsOfService extends Equatable {
  final String? userAgent;
  final String agreedAt;
  final String? ipAddress;
  const TermsOfService({
    this.userAgent,
    required this.agreedAt,
    this.ipAddress,
  });
  factory TermsOfService.fromJson(Map<String, dynamic> json) => TermsOfService(
        userAgent: json["userAgent"],
        agreedAt: json["agreedAt"],
        ipAddress: json["ipAddress"],
      );

  Map<String, dynamic> toJson() => {
        "userAgent": userAgent,
        "agreedAt": agreedAt,
        "ipAddress": ipAddress,
      };

  @override
  List<Object?> get props => [userAgent, agreedAt, ipAddress];
}
