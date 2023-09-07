import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/util/constants.dart';

import '../models/get_all_valuation_params.dart';
import '../../domain/entities/get_all_valuation_entity.dart';
import '../models/get_valuation_performance_response.dart';
import '../models/post_valuation_params.dart';

import '../models/get_valuation_performance_params.dart';
import '../../domain/entities/valuation_history_entity.dart';

import '../../domain/repositories/valuation_repository.dart';
import '../data_sources/valuation_remote_datasource.dart';

// Define a function to combine two entity lists by sorting on the `valuatedAt` field.
List<GetAllValuationEntity> combineAndSortEntityLists(
    List<GetAllValuationEntity> list1, List<GetAllValuationEntity> list2) {
  // Create a new list to store the combined entities.
  List<GetAllValuationEntity> combinedList = [];

  // Iterate over the first list.
  for (GetAllValuationEntity entity in list1) {
    // Add the entity to the combined list.
    combinedList.add(entity);
  }

  // Iterate over the second list.
  for (GetAllValuationEntity entity in list2) {
    // Add the entity to the combined list.
    combinedList.add(entity);
  }

  // Sort the combined list by the `valuatedAt` field.
  combinedList.sort((a, b) => b.valuatedAt.compareTo(a.valuatedAt));

  // Return the combined and sorted list.
  return combinedList;
}

class ValuationRepositoryImpl implements ValuationRepository {
  final ValuationRemoteDataSource remoteDataSource;

  ValuationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<GetAllValuationEntity>>> getAllValuation(
      GetAllValuationParams params) async {
    try {
      final resultTransaction =
          await remoteDataSource.getAllTransaction(params);
      if (AppConstants.isRelease2) {
        final resultValuation = await remoteDataSource.getAllValuation(params);

        List<GetAllValuationEntity> combinedList =
            combineAndSortEntityLists(resultTransaction, resultValuation);

        return Right(combinedList);
      } else {
        return Right(resultTransaction);
      }
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> postValuation(
      PostValuationParams params) async {
    try {
      final result = await remoteDataSource.postValuation(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, GetValuationPerformanceResponse>>
      getValuationPerformance(GetValuationPerformanceParams params) async {
    try {
      final result = await remoteDataSource.getValuationPerformance(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
