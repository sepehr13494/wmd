import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/login_pam_account_params.dart';

import '../repositories/pam_login_repository.dart';

class LoginPamAccountUseCase
    extends UseCase<AppSuccess, LoginPamAccountParams> {
  final PamLoginRepository repository;

  LoginPamAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(LoginPamAccountParams params) =>
      repository.loginPamAccount(params);
}
