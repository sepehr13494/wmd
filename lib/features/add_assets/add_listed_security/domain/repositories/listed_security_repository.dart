import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class ListedSecurityRepository {
  Future<Either<Failure, AddAsset>> postListedSecurity(
      AddListedSecurityParams addListedSecurityParams);
}
