import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../../core/presentataion/manager/base_assets_overview_state.dart';
import '../../domain/use_cases/get_assets_overview_usecase.dart';

part 'assets_overview_state.dart';

class AssetsOverviewCubit extends Cubit<AssetsOverviewState> {
  final GetAssetsOverviewUseCase assetsOverviewUseCase;
  final String type;
  AssetsOverviewCubit(this.assetsOverviewUseCase, this.type) : super(LoadingState());



  initPage() {
    getAssetsOverview();
  }

  getAssetsOverview() async {
    emit(LoadingState());
    final result = await assetsOverviewUseCase(AssetsOverviewParams(type: type));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (assetsOverviews) {
      assetsOverviews.sort((a, b) {
        return (b.totalAmount - a.totalAmount).toInt();
      },);
      emit(AssetsOverviewLoaded(assetsOverviews: assetsOverviews));
    });


  }
}

class AssetsOverviewCubitBankAccount extends AssetsOverviewCubit{
  AssetsOverviewCubitBankAccount(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'BankAccount');
}

class AssetsOverviewCubitListedAssetEquity extends AssetsOverviewCubit{
  AssetsOverviewCubitListedAssetEquity(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'ListedAssetEquity');
}

class AssetsOverviewCubitListedAssetOther extends AssetsOverviewCubit{
  AssetsOverviewCubitListedAssetOther(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'ListedAssetOther');
}

class AssetsOverviewCubitListedAssetFixedIncome extends AssetsOverviewCubit{
  AssetsOverviewCubitListedAssetFixedIncome(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'ListedAssetFixedIncome');
}

class AssetsOverviewCubitRealEstate extends AssetsOverviewCubit{
  AssetsOverviewCubitRealEstate(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'RealEstate');
}

class AssetsOverviewCubitPrivateEquity extends AssetsOverviewCubit{
  AssetsOverviewCubitPrivateEquity(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'PrivateEquity');
}

class AssetsOverviewCubitPrivateDebt extends AssetsOverviewCubit{
  AssetsOverviewCubitPrivateDebt(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'PrivateDebt');
}

class AssetsOverviewCubitOtherAssets extends AssetsOverviewCubit{
  AssetsOverviewCubitOtherAssets(GetAssetsOverviewUseCase assetsOverviewUseCase) : super(assetsOverviewUseCase, 'OtherAssets');
}

