import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import '../../data/models/get_custodian_bank_list_params.dart';
import '../entities/status_entity.dart';
import '../repositories/custodian_bank_auth_repository.dart';

class GetCustodianStatusListUseCase
    extends UseCase<List<StatusEntity>, GetCustodianBankListParams> {
  final CustodianBankAuthRepository repository;

  GetCustodianStatusListUseCase(this.repository);
  @override
  Future<Either<Failure, List<StatusEntity>>> call(
      GetCustodianBankListParams params) async {
    return await repository.getCustodianStatusList(params);
  }
}
