import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/entity/bank_entity.dart';

abstract class BankListRepository {
  Future<Either<Failure, List<BankEntity>>> getPopularBankList(int? count);
  Future<Either<Failure, List<BankEntity>>> getBankList(NoParams param);
}
