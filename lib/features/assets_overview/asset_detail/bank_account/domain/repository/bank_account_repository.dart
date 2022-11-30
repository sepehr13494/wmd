import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import '../entities/bank_account_entity.dart';

abstract class BankAccountRepository {
  Future<Either<Failure, List<BankAccountEntity>>> getBankAccount(
      BankAccountParams params);
}
