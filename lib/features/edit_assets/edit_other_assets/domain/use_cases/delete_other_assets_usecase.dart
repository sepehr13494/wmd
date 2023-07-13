import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_other_assets_params.dart';

import '../repositories/edit_other_assets_repository.dart';

class DeleteOtherAssetsUseCase extends UseCase<AppSuccess, DeleteOtherAssetsParams> {
  final EditOtherAssetsRepository repository;

  DeleteOtherAssetsUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteOtherAssetsParams params) =>
      repository.deleteOtherAssets(params);
}
      

    