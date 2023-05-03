import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_linked_accounts_params.dart';
import '../entities/get_linked_accounts_entity.dart';


abstract class LinkedAccountsRepository {
  Future<Either<Failure, List<GetLinkedAccountsEntity>>> getLinkedAccounts(GetLinkedAccountsParams params);

}
    