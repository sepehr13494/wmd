import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/data_sources/listed_security_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class ListedSecurityRepositoryImpl implements ListedSecurityRepository {
  final ListedSecurityRemoteDataSource listedSecurityRemoteDataSource;

  ListedSecurityRepositoryImpl(this.listedSecurityRemoteDataSource);
  @override
  Future<Either<Failure, AddAsset>> postListedSecurity(
      AddListedSecurityParams addListedSecurityParams) async {
    try {
      final result = await listedSecurityRemoteDataSource
          .postListedSecurity(addListedSecurityParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
