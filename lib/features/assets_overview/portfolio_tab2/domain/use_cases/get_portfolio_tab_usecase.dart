import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_portfolio_tab_params.dart';
import '../entities/get_portfolio_tab_entity.dart';
import '../repositories/portfolio_tab2_repository.dart';

class GetPortfolioTabUseCase {
  final PortfolioTab2Repository repository;
  final LocalStorage localStorage;

  GetPortfolioTabUseCase(this.repository, this.localStorage);
  
  Future<Either<Failure, List<GetPortfolioTabEntity>>> call(String portfolioId) =>
      repository.getPortfolioTab(GetPortfolioTabParams(portfolioId: portfolioId, ownerId: localStorage.getOwnerId()));
}
      

    