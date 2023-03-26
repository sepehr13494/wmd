import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_glossaries_params.dart';
import '../../domain/entities/get_glossaries_entity.dart';
    
import '../../domain/repositories/glossary_repository.dart';
import '../data_sources/glossary_remote_datasource.dart';

class GlossaryRepositoryImpl implements GlossaryRepository {
  final GlossaryRemoteDataSource remoteDataSource;

  GlossaryRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetGlossariesEntity>>> getGlossaries(GetGlossariesParams params) async {
    try {
      final result = await remoteDataSource.getGlossaries(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

