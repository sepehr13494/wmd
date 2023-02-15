import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_currency_params.dart';
import '../entities/get_currency_entity.dart';


abstract class CurrencyChartRepository {
  Future<Either<Failure, List<GetCurrencyEntity>>> getCurrency(GetCurrencyParams params);

}
    