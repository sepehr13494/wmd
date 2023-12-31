import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/get_market_data_params.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';

abstract class BankListRepository {
  Future<Either<Failure, List<BankEntity>>> getPopularBankList(int? count);
  Future<Either<Failure, List<BankEntity>>> getBankList(NoParams param);
  Future<Either<Failure, List<ListedSecurityName>>> getMarketData(
      GetMarketDataParams param);
}
