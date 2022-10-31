import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/each_asset_widget.dart';

class AssetViewCubit extends Cubit<EachAssetModel?>{
  AssetViewCubit() : super(null);

  selectAsset(EachAssetModel assetModel){
    emit(assetModel);
  }
}