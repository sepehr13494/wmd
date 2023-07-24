import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_portfolio_allocation_params.dart';
import '../../domain/entities/get_portfolio_allocation_entity.dart';
    import '../models/get_portfolio_tab_params.dart';
import '../../domain/entities/get_portfolio_tab_entity.dart';
    
import '../../domain/repositories/portfolio_tab2_repository.dart';
import '../data_sources/portfolio_tab2_remote_datasource.dart';

class PortfolioTab2RepositoryImpl implements PortfolioTab2Repository {
  final PortfolioTab2RemoteDataSource remoteDataSource;

  PortfolioTab2RepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetPortfolioAllocationEntity>>> getPortfolioAllocation(GetPortfolioAllocationParams params) async {
    try {
      final result = await remoteDataSource.getPortfolioAllocation(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, List<GetPortfolioTabEntity>>> getPortfolioTab(GetPortfolioTabParams params) async {
    try {
      final result = await remoteDataSource.getPortfolioTab(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

