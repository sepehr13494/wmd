import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/bank_details_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

class BankRepositoryImpl implements BankRepository {
  final BankSaveRemoteDataSource bankSaveRemoteDataSource;

  BankRepositoryImpl(this.bankSaveRemoteDataSource);
  @override
  Future<Either<Failure, BankSaveResponse>> postBankDetails(
      BankSaveParams bankSaveParams) async {
    try {
      final result =
          await bankSaveRemoteDataSource.postBankDetails(bankSaveParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
