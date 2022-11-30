import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/entities/bank_account_entity.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/repository/bank_account_repository.dart';

class GetBankAccountUseCase
    extends UseCase<List<BankAccountEntity>, BankAccountParams> {
  final BankAccountRepository bankAccountRepository;

  GetBankAccountUseCase(this.bankAccountRepository);
  @override
  Future<Either<Failure, List<BankAccountEntity>>> call(
      BankAccountParams params) {
    return bankAccountRepository.getBankAccount(params);
  }
}
