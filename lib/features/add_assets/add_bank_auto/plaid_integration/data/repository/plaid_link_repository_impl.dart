import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/data_sources/plaid_integration_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_link_repository.dart';

class PlaidLinkRepositoryImpl implements PlaidLinkRepository {
  final PlaidLinkRemoteDataSource plaidIntegrationRemoteDataSource;

  PlaidLinkRepositoryImpl(this.plaidIntegrationRemoteDataSource);
  @override
  Future<Either<Failure, String>> getLinkToken(
      String redirectUrl, String provider) async {
    try {
      final result = await plaidIntegrationRemoteDataSource.getLinkToken(
          redirectUrl, provider);
      return Right(result.linkToken!);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    }
  }

  @override
  Future<Either<Failure, String>> getPublicToken(String linkToken) async {
    try {
      final respStream =
          await plaidIntegrationRemoteDataSource.getPublicToken(linkToken);

      final converted = respStream.map<Either<Failure, String>>((e) {
        log('Plaid output: ${e.toJson()}');
        if (e is LinkExit) {
          return Left(
              ServerFailure(message: e.error?.message ?? e.metadata.status));
        } else if (e is LinkSuccess) {
          return Right((e).publicToken);
        } else {
          return Left(ServerFailure(message: e.toString()));
        }
      });
      return converted.first;
    } catch (e) {
      return Left(ServerFailure(message: '$e'));
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
