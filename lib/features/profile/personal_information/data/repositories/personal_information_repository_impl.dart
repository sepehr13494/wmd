import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/get_name_params.dart';
import '../../domain/entities/get_name_entity.dart';
    import '../models/set_name_params.dart';

    
import '../../domain/repositories/personal_information_repository.dart';
import '../data_sources/personal_information_remote_datasource.dart';

class PersonalInformationRepositoryImpl implements PersonalInformationRepository {
  final PersonalInformationRemoteDataSource remoteDataSource;

  PersonalInformationRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, GetNameEntity>> getName(GetNameParams params) async {
    try {
      final result = await remoteDataSource.getName(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> setName(SetNameParams params) async {
    try {
      final result = await remoteDataSource.setName(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      print(error);
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

