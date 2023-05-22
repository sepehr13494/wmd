import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_portfolio_tab_params.dart';
import '../entities/get_portfolio_tab_entity.dart';
import '../repositories/portfolio_tab_repository.dart';

class GetPortfolioTabUseCase extends UseCase<List<GetPortfolioTabEntity>, GetPortfolioTabParams> {
  final PortfolioTabRepository repository;

  GetPortfolioTabUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetPortfolioTabEntity>>> call(GetPortfolioTabParams params) =>
      repository.getPortfolioTab(params);
}
      

    