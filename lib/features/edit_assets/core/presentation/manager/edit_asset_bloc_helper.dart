import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';

class EditAssetBlocHelper{
  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
  }) {
    return BlocHelper.defaultBlocListener(listener: (context, state) {
      if (state is EditAssetSuccess) {
        //TODO: add after edit functions
      }
      if (state is DeleteAssetSuccess) {
        //TODO: add after delete functions
      }
    },);
  }
}
