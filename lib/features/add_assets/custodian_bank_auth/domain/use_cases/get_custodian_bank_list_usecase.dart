import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_custodian_bank_list_params.dart';
import '../entities/custodian_bank_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class GetCustodianBankListUseCase
    extends UseCase<List<CustodianBankEntity>, GetCustodianBankListParams> {
  final CustodianBankAuthRepository repository;

  GetCustodianBankListUseCase(this.repository);
  @override
  Future<Either<Failure, List<CustodianBankEntity>>> call(
          GetCustodianBankListParams params) =>
      repository.getCustodianBankList(params);
}
