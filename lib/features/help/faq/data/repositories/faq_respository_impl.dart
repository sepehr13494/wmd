import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';

import 'package:wmd/features/help/faq/data/data_sources/faq_remote_data_source.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/domain/repositories/faq_repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRemoteDataSource faqRemoteDataSource;

  FaqRepositoryImpl(this.faqRemoteDataSource);

  @override
  Future<Either<Failure, List<Faq>>> getFAQs(NoParams noParams) async {
    try {
      final result = await faqRemoteDataSource.getFAQs(noParams);

      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message, type: error.type));
    }
  }
}
