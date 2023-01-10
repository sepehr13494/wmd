import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_chart_params.dart';
import '../entities/get_chart_entity.dart';
import '../repositories/charts_repository.dart';

class GetChartUseCase extends UseCase<List<GetChartEntity>, dynamic> {
  final ChartsRepository repository;
  final LocalStorage localStorage;

  GetChartUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetChartEntity>>> call(dynamic params) async {
    return await repository.getChart(GetChartParams(userid: localStorage.getOwnerId(),from: DateTime.now().subtract(Duration(days: params == null ? 0 : params.value)).toIso8601String(),to: DateTime.now().toIso8601String()));
  }
}
      

    