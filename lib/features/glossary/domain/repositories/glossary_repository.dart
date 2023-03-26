import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_glossaries_params.dart';
import '../entities/get_glossaries_entity.dart';


abstract class GlossaryRepository {
  Future<Either<Failure, List<GetGlossariesEntity>>> getGlossaries(GetGlossariesParams params);

}
    