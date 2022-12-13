import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_custodian_bank_status_params.dart';
import '../entities/get_custodian_bank_status_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class GetCustodianBankStatusUseCase
    extends UseCase<CustodianBankStatusEntity, GetCustodianBankStatusParams> {
  final CustodianBankAuthRepository repository;

  GetCustodianBankStatusUseCase(this.repository);

  @override
  Future<Either<Failure, CustodianBankStatusEntity>> call(
          GetCustodianBankStatusParams params) =>
      repository.getCustodianBankStatus(params);
}
