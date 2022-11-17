import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_private_equity/data/data_sources/private_equity_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/repositories/private_equity_repository.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';

class PrivateEquityRepositoryImpl implements PrivateEquityRepository {
  final PrivateEquityRemoteDataSource privateEquityRemoteDataSource;

  PrivateEquityRepositoryImpl(this.privateEquityRemoteDataSource);
  @override
  Future<Either<Failure, AddAsset>> postPrivateEquity(
      AddPrivateEquityParams addPrivateEquityParams) async {
    try {
      final result = await privateEquityRemoteDataSource
          .postPrivateEquityDetails(addPrivateEquityParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
