import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_other_assets_params.dart';

import '../../data/models/delete_other_assets_params.dart';



abstract class EditOtherAssetsRepository {
  Future<Either<Failure, AppSuccess>> putOtherAssets(PutOtherAssetsParams params);
  Future<Either<Failure, AppSuccess>> deleteOtherAssets(DeleteOtherAssetsParams params);

}
    