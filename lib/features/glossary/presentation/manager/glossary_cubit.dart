import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_glossaries_params.dart';
import '../../domain/use_cases/get_glossaries_usecase.dart';
import '../../domain/entities/get_glossaries_entity.dart';


part 'glossary_state.dart';

class GlossaryCubit extends Cubit<GlossaryState> {

  final GetGlossariesUseCase getGlossariesUseCase;


  GlossaryCubit(
    this.getGlossariesUseCase,
  ) : super(LoadingState());

  late List<GetGlossariesEntity> fullGlossaries;

  getGlossaries() async {
    emit(LoadingState());
    final result = await getGlossariesUseCase(GetGlossariesParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      fullGlossaries = entities;
      emit(GetGlossariesLoaded(getGlossariesEntities: entities));
    });
  }

  searchGlossaries({required String searchedValue}) async {
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 200));
    if(searchedValue == ""){
      emit(GetGlossariesLoaded(getGlossariesEntities: fullGlossaries));
    }else{
      List<GetGlossariesEntity> second = [];
      for (var element in fullGlossaries) {
        List<RecordEntity> records = [];
        for (var element in element.record) {
          records.add(RecordEntity(term: element.term, definition: element.definition));
        }
        second.add(GetGlossariesEntity(alphabet: element.alphabet, record: records));
      }
      for (var mainElement in second) {
        mainElement.record.removeWhere((element) => !element.term.toLowerCase().contains(searchedValue.toLowerCase()));
      }
      emit(GetGlossariesLoaded(getGlossariesEntities: second));
    }
  }

}

