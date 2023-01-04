import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddAssetState extends BaseState {
  final AddAsset addAsset;

  AddAssetState({required this.addAsset});

  @override
  List<Object?> get props => [addAsset];
}
