import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_linked_accounts_params.dart';
import '../../domain/use_cases/get_linked_accounts_usecase.dart';
import '../../domain/entities/get_linked_accounts_entity.dart';


part 'linked_accounts_state.dart';

class LinkedAccountsCubit extends Cubit<LinkedAccountsState> {

  final GetLinkedAccountsUseCase getLinkedAccountsUseCase;


  LinkedAccountsCubit(
    this.getLinkedAccountsUseCase,
  ) : super(LoadingState());

  getLinkedAccounts() async {
    emit(LoadingState());
    final result = await getLinkedAccountsUseCase(GetLinkedAccountsParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetLinkedAccountsLoaded(getLinkedAccountsEntities: entities));
    });
  }
  

}

    