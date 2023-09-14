import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/request_new_custodian_params.dart';
import '../../domain/use_cases/request_new_custodian_usecase.dart';



part 'request_new_custodian_state.dart';

class RequestNewCustodianCubit extends Cubit<RequestNewCustodianState> {

  final RequestNewCustodianUseCase requestNewCustodianUseCase;


  RequestNewCustodianCubit(
    this.requestNewCustodianUseCase,
  ) : super(LoadingState());

  requestNewCustodian() async {
    emit(LoadingState());
    final result = await requestNewCustodianUseCase(RequestNewCustodianParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
      
    });
  }
  

}

    