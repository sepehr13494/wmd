import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/get_market_data_params.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import '../repository/bank_list_repository.dart';

class GetMarketDataUseCase
    extends UseCase<List<ListedSecurityName>, GetMarketDataParams> {
  final BankListRepository bankListRepository;

  GetMarketDataUseCase(this.bankListRepository);

  List<ListedSecurityName>? banks;

  @override
  Future<Either<Failure, List<ListedSecurityName>>> call(
      GetMarketDataParams params) async {
    final temp = await bankListRepository.getMarketData(params);
    _cache(temp);
    return temp;
  }

  void _cache(Either<Failure, List<ListedSecurityName>> temp) {
    temp.fold((l) => null, (r) {
      banks = List.from(r);
    });
  }
}
