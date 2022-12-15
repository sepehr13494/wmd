import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/help/support/data/data_sources/general_inquiry_remote_data_source.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';

class GeneralInquiryRepositoryImpl implements GeneralInquiryRepository {
  final GeneralInquiryRemoteDataSource generalInquiryRemoteDataSource;
  final LocalStorage localStorage;

  GeneralInquiryRepositoryImpl(
      this.generalInquiryRemoteDataSource, this.localStorage);
  @override
  Future<Either<Failure, UserStatus>> postGeneralInquiry(
      NoParams noParams) async {
    try {
      final result =
          await generalInquiryRemoteDataSource.postGeneralInquiry(noParams);
      localStorage.setOwnerId(result.userId);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message, type: error.type));
    }
  }
}
