import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/login_tfo_account_params.dart';

import '../repositories/tfo_login_repository.dart';

class LoginTfoAccountUseCase
    extends UseCase<AppSuccess, LoginTfoAccountParams> {
  final TfoLoginRepository repository;

  LoginTfoAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(LoginTfoAccountParams params) =>
      repository.loginTfoAccount(params);
}
