import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_linked_accounts_params.dart';
import '../entities/get_linked_accounts_entity.dart';
import '../repositories/linked_accounts_repository.dart';

class GetLinkedAccountsUseCase extends UseCase<List<GetLinkedAccountsEntity>, GetLinkedAccountsParams> {
  final LinkedAccountsRepository repository;

  GetLinkedAccountsUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetLinkedAccountsEntity>>> call(GetLinkedAccountsParams params) =>
      repository.getLinkedAccounts(params);
}
      

    