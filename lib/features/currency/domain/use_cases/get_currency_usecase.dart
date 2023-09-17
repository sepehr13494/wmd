import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_currency_params.dart';
import '../entities/get_currency_entity.dart';
import '../repositories/currency_repository.dart';

class GetCurrencyConversionUseCase
    extends UseCase<GetCurrencyEntity, GetCurrencyParams> {
  final CurrencyRepository repository;

  GetCurrencyConversionUseCase(this.repository);

  @override
  Future<Either<Failure, GetCurrencyEntity>> call(GetCurrencyParams params) =>
      repository.getCurrency(params);
}
