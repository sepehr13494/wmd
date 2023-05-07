import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';


import '../../data/models/get_linked_accounts_params.dart';
import '../entities/get_linked_accounts_entity.dart';


abstract class LinkedAccountsRepository {
  Future<Either<Failure, List<GetLinkedAccountsEntity>>> getLinkedAccounts(GetLinkedAccountsParams params);
  Future<Either<Failure, AppSuccess>> deleteLinkedAccounts(DeleteCustodianBankStatusParams params);

}
    