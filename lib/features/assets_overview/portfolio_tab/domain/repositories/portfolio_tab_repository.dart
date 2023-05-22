import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_portfolio_tab_params.dart';
import '../entities/get_portfolio_tab_entity.dart';


abstract class PortfolioTabRepository {
  Future<Either<Failure, List<GetPortfolioTabEntity>>> getPortfolioTab(GetPortfolioTabParams params);

}
    