import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

part 'listed_security_state.dart';

class ListedSecurityCubit extends Cubit<ListedSecurityState> {
  final AddListedSecurityUseCase addListedSecurityUseCase;

  ListedSecurityCubit(this.addListedSecurityUseCase)
      : super(ListedSecurityInitial());

  postListedSecurity({required Map<String, dynamic> map}) async {
    print(map);
    emit(LoadingState());
    final result = await addListedSecurityUseCase(map);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (saveSuccess) =>
            emit(ListedSecuritySaved(listedSecuritySaveResponse: saveSuccess)));
  }
}