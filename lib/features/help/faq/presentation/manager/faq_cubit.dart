import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/domain/use_cases/get_faq_usecase.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final GetFaqUseCase getFaqUseCase;

  FaqCubit(this.getFaqUseCase) : super(LoadingState());

  getFAQs() async {
    emit(LoadingState());
    final result = await getFaqUseCase(NoParams());
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (userStatusSuccess) {
      emit(FaqLoaded(faqs: userStatusSuccess));
    });
  }
}
