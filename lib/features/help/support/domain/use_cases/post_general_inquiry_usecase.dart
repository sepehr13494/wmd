import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';

class PostGeneralInquiryUseCase extends UseCase<UserStatus, NoParams> {
  final GeneralInquiryRepository generalInquiryRepository;

  PostGeneralInquiryUseCase(this.generalInquiryRepository);
  @override
  Future<Either<Failure, UserStatus>> call(NoParams params) =>
      generalInquiryRepository.postGeneralInquiry(params);
}
