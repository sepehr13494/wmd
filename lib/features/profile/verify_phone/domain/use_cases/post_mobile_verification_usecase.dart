import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/post_verify_phone_params.dart';

import '../repositories/verify_phone_repository.dart';

class PostMobileVerificationUseCase
    extends UseCase<AppSuccess, PostVerifyPhoneParams> {
  final VerifyPhoneRepository repository;

  PostMobileVerificationUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(PostVerifyPhoneParams params) =>
      repository.postMobileVerification(params);
}
