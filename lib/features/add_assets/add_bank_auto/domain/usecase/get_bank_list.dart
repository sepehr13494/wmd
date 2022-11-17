import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/entity/bank_entity.dart';
import '../repository/bank_list_repository.dart';

class GetBankListsUseCase extends UseCase<List<BankEntity>, String> {
  final BankListRepository bankListRepository;

  GetBankListsUseCase(this.bankListRepository);

  List<BankEntity>? banks;

  @override
  Future<Either<Failure, List<BankEntity>>> call(String params) async {
    if (banks != null && banks!.isNotEmpty) {
      return Right(_filter(banks!, params));
    } else {
      final temp = await bankListRepository.getBankList(NoParams());
      _cache(temp);
      return temp.bimap((l) => l, (r) => _filter(r, params));
    }
  }

  List<BankEntity> _filter(List<BankEntity> list, String text) {
    return list.where((e) => e.name.contains(text)).toList();
  }

  void _cache(Either<Failure, List<BankEntity>> temp) {
    temp.fold((l) => null, (r) {
      banks = List.from(r);
    });
  }
}
