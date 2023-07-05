import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_manual_list_params.dart';
import '../../domain/entities/get_manual_list_entity.dart';
    
import '../../domain/repositories/manual_bank_list_repository.dart';
import '../data_sources/manual_bank_list_remote_datasource.dart';

class ManualBankListRepositoryImpl implements ManualBankListRepository {
  final ManualBankListRemoteDataSource remoteDataSource;

  ManualBankListRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetManualListEntity>>> getManualList(GetManualListParams params) async {
    try {
      final result = await remoteDataSource.getManualList(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

