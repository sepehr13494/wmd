import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import '../repositories/linked_accounts_repository.dart';

class DeleteLinkedAccountsUseCase extends UseCase<AppSuccess, DeleteCustodianBankStatusParams> {
  final LinkedAccountsRepository repository;

  DeleteLinkedAccountsUseCase(this.repository);
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteCustodianBankStatusParams params) =>
      repository.deleteLinkedAccounts(params);
}
