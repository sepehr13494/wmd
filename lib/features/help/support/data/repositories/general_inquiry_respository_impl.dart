import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/data/data_sources/general_inquiry_remote_data_source.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

class GeneralInquiryRepositoryImpl implements GeneralInquiryRepository {
  final GeneralInquiryRemoteDataSource generalInquiryRemoteDataSource;

  GeneralInquiryRepositoryImpl(this.generalInquiryRemoteDataSource);
  @override
  Future<Either<Failure, AppSuccess>> postGeneralInquiry(
      GeneralInquiryParams params) async {
    try {
      final result =
          await generalInquiryRemoteDataSource.postGeneralInquiry(params);

      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message, type: error.type));
    }
  }
}
