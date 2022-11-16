import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/bank_list_response.dart';
import '../repository/bank_list_repository.dart';

class GetPopularBankListUseCase extends UseCase<List<BankResponse>, NoParams> {
  final BankListRepository bankListRepository;

  GetPopularBankListUseCase(this.bankListRepository);

  @override
  Future<Either<Failure, List<BankResponse>>> call(NoParams params) async {
    return await bankListRepository.getPopularBankList(params);
  }
}
