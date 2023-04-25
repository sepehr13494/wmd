import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_listed_asset_params.dart';

import '../repositories/edit_listed_asset_repository.dart';

class DeleteListedAssetUseCase extends UseCase<AppSuccess, DeleteListedAssetParams> {
  final EditListedAssetRepository repository;

  DeleteListedAssetUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteListedAssetParams params) =>
      repository.deleteListedAsset(params);
}
      

    