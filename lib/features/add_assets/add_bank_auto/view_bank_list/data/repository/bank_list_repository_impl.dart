import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/get_market_data_params.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import '../../domain/repository/bank_list_repository.dart';
import '../data_sources/bank_list_data_source.dart';

class BankListRepositoryImpl implements BankListRepository {
  final BankListRemoteDataSource bankListRemoteDataSource;

  BankListRepositoryImpl(this.bankListRemoteDataSource);

  @override
  Future<Either<Failure, List<BankEntity>>> getBankList(NoParams param) async {
    try {
      final result = await bankListRemoteDataSource.getBankList(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, List<BankEntity>>> getPopularBankList(
      int? count) async {
    try {
      final result = await bankListRemoteDataSource.getPopularBankList(count);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, List<ListedSecurityName>>> getMarketData(
      GetMarketDataParams params) async {
    try {
      final result = await bankListRemoteDataSource.getMarketData(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
