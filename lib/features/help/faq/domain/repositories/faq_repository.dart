import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<Faq>>> getFAQs(NoParams noParams);
}
