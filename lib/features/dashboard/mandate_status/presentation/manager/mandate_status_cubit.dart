import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_mandate_status_params.dart';
import '../../domain/use_cases/get_mandate_status_usecase.dart';
import '../../domain/entities/get_mandate_status_entity.dart';
import '../../data/models/delete_mandate_params.dart';
import '../../domain/use_cases/delete_mandate_usecase.dart';



part 'mandate_status_state.dart';

class MandateStatusCubit extends Cubit<MandateStatusState> {

  final GetMandateStatusUseCase getMandateStatusUseCase;
  final DeleteMandateUseCase deleteMandateUseCase;


  MandateStatusCubit(
    this.getMandateStatusUseCase,
    this.deleteMandateUseCase,
  ) : super(LoadingState());

  getMandateStatus() async {
    emit(LoadingState());
    final result = await getMandateStatusUseCase(GetMandateStatusParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetMandateStatusLoaded(getMandateStatusEntities: entities));
    });
  }
  
  deleteMandate() async {
    emit(LoadingState());
    final result = await deleteMandateUseCase(DeleteMandateParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
      
    });
  }
  

}

    