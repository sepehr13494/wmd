import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/put_custodian_bank_status_params.dart';
import '../entities/post_custodian_bank_status_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class PutCustodianBankStatusUseCase extends UseCase<
    PostCustodianBankStatusEntity, PutCustodianBankStatusParams> {
  final CustodianBankAuthRepository repository;

  PutCustodianBankStatusUseCase(this.repository);

  @override
  Future<Either<Failure, PostCustodianBankStatusEntity>> call(
          PutCustodianBankStatusParams params) =>
      repository.putCustodianBankStatus(params);
}
