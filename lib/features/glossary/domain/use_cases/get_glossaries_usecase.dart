import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_glossaries_params.dart';
import '../entities/get_glossaries_entity.dart';
import '../repositories/glossary_repository.dart';

class GetGlossariesUseCase extends UseCase<List<GetGlossariesEntity>, GetGlossariesParams> {
  final GlossaryRepository repository;

  GetGlossariesUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetGlossariesEntity>>> call(GetGlossariesParams params) =>
      repository.getGlossaries(params);
}
      

    