import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/post_resend_verify_phone_params.dart';

import '../repositories/verify_phone_repository.dart';

class PostResendVerifyPhoneUseCase extends UseCase<AppSuccess, PostResendVerifyPhoneParams> {
  final VerifyPhoneRepository repository;

  PostResendVerifyPhoneUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(PostResendVerifyPhoneParams params) =>
      repository.postResendVerifyPhone(params);
}
      

    