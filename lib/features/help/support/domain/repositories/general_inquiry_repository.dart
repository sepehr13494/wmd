import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

abstract class GeneralInquiryRepository {
  Future<Either<Failure, AppSuccess>> postGeneralInquiry(
      GeneralInquiryParams params);
}
