import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/post_custodian_bank_status_params.dart';
import '../entities/post_custodian_bank_status_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class PostCustodianBankStatusUseCase extends UseCase<PostCustodianBankStatusEntity, PostCustodianBankStatusParams> {
  final CustodianBankAuthRepository repository;

  PostCustodianBankStatusUseCase(this.repository);
  
  @override
  Future<Either<Failure, PostCustodianBankStatusEntity>> call(PostCustodianBankStatusParams params) =>
      repository.postCustodianBankStatus(params);
}
      

    