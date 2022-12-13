import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_geographic_params.dart';
import '../entities/get_geographic_entity.dart';
import '../repositories/dashboard_charts_repository.dart';

class GetGeographicUseCase extends UseCase<List<GetGeographicEntity>, NoParams> {
  final DashboardChartsRepository repository;
  final LocalStorage localStorage;

  GetGeographicUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetGeographicEntity>>> call(NoParams params) =>
      repository.getGeographic(GetGeographicParams(ownerId: localStorage.getOwnerId()));
}
      

    