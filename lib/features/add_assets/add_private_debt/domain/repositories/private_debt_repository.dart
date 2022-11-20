import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class PrivateDebtRepository {
  Future<Either<Failure, AddAsset>> postPrivateDebt(
      AddPrivateDebtParams addPrivateDebtParams);
}
