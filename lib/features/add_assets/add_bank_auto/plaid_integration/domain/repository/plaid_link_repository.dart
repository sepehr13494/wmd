import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

abstract class PlaidLinkRepository {
  Future<Either<Failure, String>> getLinkToken(String redirectUrl);
  Future<Either<Failure, String>> postPublicToken(String publicToken);
}
