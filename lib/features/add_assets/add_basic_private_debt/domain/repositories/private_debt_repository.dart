import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/entities/private_debt_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/use_cases/post_private_debt_usecase.dart';

abstract class PrivateDebtRepository {
  Future<Either<Failure, PrivateDebtSaveResponse>> postPrivateDebt(
      PrivateDebtSaveParams privateDebtSaveParams);
}
