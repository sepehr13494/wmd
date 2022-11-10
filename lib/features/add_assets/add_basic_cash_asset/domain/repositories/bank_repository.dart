import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

abstract class BankRepository {
  Future<Either<Failure, BankSaveResponse>> postBankDetails(
      BankSaveParams bankSaveParams);
}
