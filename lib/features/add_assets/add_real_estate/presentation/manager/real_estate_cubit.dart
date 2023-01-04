import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

part 'real_estate_state.dart';

class RealEstateCubit extends Cubit<RealEstateState> {
  final AddRealEstateUseCase addRealEstateUseCase;

  RealEstateCubit(this.addRealEstateUseCase) : super(RealEstateInitial());

  postRealEstate({required Map<String, dynamic> map}) async {
    print(map);
    emit(LoadingState());
    final result = await addRealEstateUseCase(map);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (realEstateSaveSuccess) =>
            emit(AddAssetState(addAsset: realEstateSaveSuccess)));
  }
}
