import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_bank_list.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_popular_bank_list.dart';

part 'bank_list_state.dart';

class BankListCubit extends Cubit<BankListState> {
  final GetBankListsUseCase getBankListsUseCase;
  final GetPopularBankListUseCase getPopularBankListUseCase;

  BankListCubit(this.getBankListsUseCase, this.getPopularBankListUseCase)
      : super(GetBankListInitial());

  getBankList(String text) async {
    emit(LoadingState());
    final result = await getBankListsUseCase(text);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (banks) => emit(BankListSuccess(banks)));
  }

  getPopularBankList() async {
    emit(LoadingState());
    final result =
        await getPopularBankListUseCase(NoParams()); //number of popular banks
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (banks) => emit(PopularBankListSuccess(banks)));
  }
}
