import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/get_asset_see_more_params.dart';



abstract class AssetSeeMoreRepository {
  Future<Either<Failure, AppSuccess>> getAssetSeeMore(GetSeeMoreParams params);

}
    