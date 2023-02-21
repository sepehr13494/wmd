import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';

import '../../data/models/post_custodian_bank_status_params.dart';
import '../entities/post_custodian_bank_status_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class DeleteCustodianBankStatusUseCase
    extends UseCase<AppSuccess, DeleteCustodianBankStatusParams> {
  final CustodianBankAuthRepository repository;

  DeleteCustodianBankStatusUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(
          DeleteCustodianBankStatusParams params) =>
      repository.deleteCustodianBankStatus(params);
}
