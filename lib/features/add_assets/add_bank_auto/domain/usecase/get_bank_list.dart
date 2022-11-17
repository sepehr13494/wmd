import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/entity/bank_entity.dart';

import '../repository/bank_list_repository.dart';

class GetBankListsUseCase extends UseCase<List<BankEntity>, NoParams> {
  final BankListRepository bankListRepository;

  GetBankListsUseCase(this.bankListRepository);

  List<BankEntity>? banks;

  @override
  Future<Either<Failure, List<BankEntity>>> call(NoParams params) async {
    if (banks != null && banks!.isNotEmpty) {
      return Right(banks!);
    } else {
      final temp = await bankListRepository.getBankList(params);
      temp.fold((l) => null, (r) {
        banks = List.from(r);
      });
      return temp;
    }
  }
}
