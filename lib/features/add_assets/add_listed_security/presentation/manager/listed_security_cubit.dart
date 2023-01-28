import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/models/listed_security_name.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/get_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

part 'listed_security_state.dart';

class ListedSecurityCubit extends Cubit<ListedSecurityState> {
  final AddListedSecurityUseCase addListedSecurityUseCase;
  final GetListedSecurityUseCase getListedSecurityUseCase;

  ListedSecurityCubit(
      this.addListedSecurityUseCase, this.getListedSecurityUseCase)
      : super(ListedSecurityInitial());

  postListedSecurity({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await addListedSecurityUseCase(map);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (saveSuccess) => emit(AddAssetState(addAsset: saveSuccess)));
  }

  getListedSecurity(String text) async {
    emit(LoadingState());
    final result = await getListedSecurityUseCase(text);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (assets) => emit(ListedSecuritySuccess(assets)));
  }
}
