import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_listed_asset_params.dart';

import '../../data/models/delete_listed_asset_params.dart';



abstract class EditListedAssetRepository {
  Future<Either<Failure, AppSuccess>> putListedAsset(PutListedAssetParams params);
  Future<Either<Failure, AppSuccess>> deleteListedAsset(DeleteListedAssetParams params);

}
    