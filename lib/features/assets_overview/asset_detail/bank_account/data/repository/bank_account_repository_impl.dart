import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/data_sources/bank_account_remote_datasource.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/entities/bank_account_entity.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/repository/bank_account_repository.dart';

class BankAccountRepositoryImpl extends BankAccountRepository {
  final BankAccountRemoteDataSource bankAccountRemoteDataSource;

  BankAccountRepositoryImpl(this.bankAccountRemoteDataSource);
  @override
  Future<Either<Failure, BankAccountEntity>> getBankAccount(
      BankAccountParams params) async {
    try {
      final result = await bankAccountRemoteDataSource.getBankAccount(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
