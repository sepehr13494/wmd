import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_allocation_params.dart';
import '../entities/get_allocation_entity.dart';
import '../repositories/dashboard_charts_repository.dart';

class GetAllocationUseCase extends UseCase<List<GetAllocationEntity>, NoParams> {
  final DashboardChartsRepository repository;
  final LocalStorage localStorage;

  GetAllocationUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetAllocationEntity>>> call(NoParams params) =>
      repository.getAllocation(GetAllocationParams(ownerId: localStorage.getOwnerId()));
}
      

    