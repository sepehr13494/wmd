import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/models/bank_list_response.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/bank_list_repository.dart';
import '../data_sources/bank_list_data_source.dart';

class BankListRepositoryImpl implements BankListRepository {
  final BankListRemoteDataSource bankListRemoteDataSource;

  BankListRepositoryImpl(this.bankListRemoteDataSource);

  @override
  Future<Either<Failure, List<BankResponse>>> getBankList(
      NoParams param) async {
    try {
      final result = await bankListRemoteDataSource.getBankList(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<BankResponse>>> getPopularBankList(
      NoParams param) async {
    try {
      final result = await bankListRemoteDataSource.getPopularBankList(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    }
  }
}
