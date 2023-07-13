import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_manual_list_params.dart';
import '../entities/get_manual_list_entity.dart';
import '../repositories/manual_bank_list_repository.dart';

class GetManualListUseCase extends UseCase<List<GetManualListEntity>, GetManualListParams> {
  final ManualBankListRepository repository;

  GetManualListUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetManualListEntity>>> call(GetManualListParams params) =>
      repository.getManualList(params);
}
      

    