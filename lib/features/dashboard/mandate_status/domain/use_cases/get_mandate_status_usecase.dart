import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_mandate_status_params.dart';
import '../entities/get_mandate_status_entity.dart';
import '../repositories/mandate_status_repository.dart';

class GetMandateStatusUseCase extends UseCase<List<GetMandateStatusEntity>, GetMandateStatusParams> {
  final MandateStatusRepository repository;

  GetMandateStatusUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetMandateStatusEntity>>> call(GetMandateStatusParams params) =>
      repository.getMandateStatus(params);
}
      

    