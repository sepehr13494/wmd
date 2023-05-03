import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_client_index_params.dart';
import '../../domain/use_cases/get_client_index_usecase.dart';
import '../../domain/entities/get_client_index_entity.dart';


part 'client_index_state.dart';

class ClientIndexCubit extends Cubit<ClientIndexState> {

  final GetClientIndexUseCase getClientIndexUseCase;


  ClientIndexCubit(
    this.getClientIndexUseCase,
  ) : super(LoadingState());

  getClientIndex({TimeFilterObj? period}) async {
    emit(LoadingState());
    final result = await getClientIndexUseCase(GetClientIndexParams(period: period?.value ?? "ITD"));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entity) {
      
      emit(GetClientIndexLoaded(getClientIndexEntity: entity));
    });
  }
  

}

    