import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/each_asset_widget.dart';
part 'asset_view_state.dart';

class AssetViewCubit extends Cubit<AssetViewState?> {
  AssetViewCubit() : super(null);

  selectCustodian() {
    emit(CustodianPage());
  }

  empty() {
    emit(null);
  }

  selectAsset(EachAssetModel assetModel) {
    print(assetModel.title);
    emit(assetModel);
  }
}
