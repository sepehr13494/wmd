import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_manual_list_params.dart';
import '../../domain/use_cases/get_manual_list_usecase.dart';
import '../../domain/entities/get_manual_list_entity.dart';


part 'manual_bank_list_state.dart';

class ManualBankListCubit extends Cubit<ManualBankListState> {

  final GetManualListUseCase getManualListUseCase;


  ManualBankListCubit(
    this.getManualListUseCase,
  ) : super(LoadingState());

  getManualList({required String text}) async {
    emit(LoadingState());
    final result = await getManualListUseCase(GetManualListParams(bankName: text));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetManualListLoaded(getManualListEntities: entities));
    });
  }
  

}

    