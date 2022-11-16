import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/models/bank_list_response.dart';

abstract class BankListRepository {
  Future<Either<Failure, List<BankResponse>>> getPopularBankList(
      NoParams param);
  Future<Either<Failure, List<BankResponse>>> getBankList(NoParams param);
}
