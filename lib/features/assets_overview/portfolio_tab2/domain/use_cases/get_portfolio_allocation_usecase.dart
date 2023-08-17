import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_portfolio_allocation_params.dart';
import '../entities/get_portfolio_allocation_entity.dart';
import '../repositories/portfolio_tab2_repository.dart';

class GetPortfolioAllocationUseCase {
  final PortfolioTab2Repository repository;
  final LocalStorage localStorage;

  GetPortfolioAllocationUseCase(this.repository, this.localStorage);

  Future<Either<Failure, List<GetPortfolioAllocationEntity>>> call() =>
      repository.getPortfolioAllocation(GetPortfolioAllocationParams(ownerId: localStorage.getOwnerId()));
}
      

    