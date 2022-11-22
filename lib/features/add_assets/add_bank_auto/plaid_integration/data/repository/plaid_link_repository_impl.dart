import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/data_sources/plaid_integration_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_link_repository.dart';

class PlaidLinkRepositoryImpl implements PlaidLinkRepository {
  final PlaidIntegrationRemoteDataSource plaidIntegrationRemoteDataSource;

  PlaidLinkRepositoryImpl(this.plaidIntegrationRemoteDataSource);
  @override
  Future<Either<Failure, String>> getLinkToken(String redirectUrl) async {
    try {
      final result =
          await plaidIntegrationRemoteDataSource.getLinkToken(redirectUrl);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> getPublicToken(String linkToken) async {
    try {
      final publicToken =
          await plaidIntegrationRemoteDataSource.getPublicToken(linkToken);
      return Right(publicToken);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> postPublicToken(String publicToken) async {
    try {
      final result =
          await plaidIntegrationRemoteDataSource.postPublicToken(publicToken);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
