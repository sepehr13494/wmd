import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_detail_params.dart';
import '../entities/get_detail_entity.dart';
import '../repositories/asset_detail_repository.dart';

class GetDetailUseCase extends UseCase<GetDetailEntity, GetDetailParams> {
  final AssetDetailRepository repository;

  GetDetailUseCase(this.repository);
  
  @override
  Future<Either<Failure, GetDetailEntity>> call(GetDetailParams params) =>
      repository.getDetail(params);
}
      

    