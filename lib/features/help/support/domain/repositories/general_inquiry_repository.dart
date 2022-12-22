import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

abstract class GeneralInquiryRepository {
  Future<Either<Failure, UserStatus>> postGeneralInquiry(
      GeneralInquiryParams params);
}
