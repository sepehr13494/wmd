import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class PrivateEquityRepository {
  Future<Either<Failure, AddAsset>> postPrivateEquity(
      AddPrivateEquityParams addPrivateEquityParams);
}
