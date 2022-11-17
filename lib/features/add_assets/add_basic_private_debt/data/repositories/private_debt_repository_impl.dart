import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/data/data_sources/private_debt_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/entities/private_debt_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/repositories/private_debt_repository.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/use_cases/post_private_debt_usecase.dart';

class PrivateDebtRepositoryImpl implements PrivateDebtRepository {
  final PrivateDebtSaveRemoteDataSource privateDebtSaveRemoteDataSource;

  PrivateDebtRepositoryImpl(this.privateDebtSaveRemoteDataSource);
  @override
  Future<Either<Failure, PrivateDebtSaveResponse>> postPrivateDebt(
      PrivateDebtSaveParams privateDebtSaveParams) async {
    try {
      final result = await privateDebtSaveRemoteDataSource
          .postPrivateDebt(privateDebtSaveParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
