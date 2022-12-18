import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_chart_params.dart';
import '../entities/get_chart_entity.dart';
import '../repositories/charts_repository.dart';

class GetChartUseCase extends UseCase<List<GetChartEntity>, DateTime> {
  final ChartsRepository repository;
  final LocalStorage localStorage;

  GetChartUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetChartEntity>>> call(DateTime params) async {
    return await repository.getChart(GetChartParams(userid: localStorage.getOwnerId(), to: params.toIso8601String()));
  }
}
      

    