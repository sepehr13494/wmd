import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_currency_params.dart';
import '../entities/get_currency_entity.dart';
import '../repositories/currency_chart_repository.dart';

class GetCurrencyUseCase extends UseCase<List<GetCurrencyEntity>, NoParams> {
  final CurrencyChartRepository repository;
  final LocalStorage localStorage;

  GetCurrencyUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetCurrencyEntity>>> call(NoParams params) {
    return repository.getCurrency(GetCurrencyParams(userId: localStorage.getOwnerId()));
  }
}


    