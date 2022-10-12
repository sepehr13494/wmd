/*
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/domain/repositories/login_sign_up_repository.dart';

class LinkedInLoginUseCase extends UseCase<AppSuccess, LinkedInLoginParams> {
  final AuthRepository authRepository;

  LinkedInLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(LinkedInLoginParams params) async {
    return await authRepository.linkedInLogin(params);
  }
}

class LinkedInLoginParams extends Equatable {

  const LinkedInLoginParams();

  Map<String, dynamic> toJson() => {

  };

  factory LinkedInLoginParams.fromJson(Map<String, dynamic> json) {
    return const LinkedInLoginParams();
  }

  @override
  List<Object?> get props => [];
}*/
