import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';
import '../../data/models/get_asset_see_more_params.dart';
import '../repositories/asset_see_more_repository.dart';

class GetSeeMoreUseCase extends UseCase<GetSeeMoreResponse, GetSeeMoreParams> {
  final AssetSeeMoreRepository repository;

  GetSeeMoreUseCase(this.repository);

  @override
  Future<Either<Failure, GetSeeMoreResponse>> call(GetSeeMoreParams params) =>
      repository.getAssetSeeMore(params);
}
