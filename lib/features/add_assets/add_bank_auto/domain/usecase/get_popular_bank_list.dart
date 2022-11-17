import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/entity/bank_entity.dart';
import '../repository/bank_list_repository.dart';

class GetPopularBankListUseCase extends UseCase<List<BankEntity>, NoParams> {
  final BankListRepository bankListRepository;

  GetPopularBankListUseCase(this.bankListRepository);

  @override
  Future<Either<Failure, List<BankEntity>>> call(NoParams params) async {
    return await bankListRepository.getPopularBankList(params);
  }
}
