import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_pie_params.dart';
import '../entities/get_pie_entity.dart';
import '../repositories/dashboard_charts_repository.dart';

class GetPieUseCase extends UseCase<List<GetPieEntity>, NoParams> {
  final DashboardChartsRepository repository;
  final LocalStorage localStorage;

  GetPieUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetPieEntity>>> call(NoParams params) =>
      repository.getPie(GetPieParams(ownerId: localStorage.getOwnerId()));
}
      

    