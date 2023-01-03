import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankSaveState> {
  final PostBankDetailsUseCase postBankDetailsUseCase;
  BankCubit(this.postBankDetailsUseCase) : super(BankDetailInitial());

  postBankDetails({required Map<String, dynamic> map}) async {
    print(map);
    emit(LoadingState());
    final result = await postBankDetailsUseCase(map);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (bankSaveSuccess) => emit(AddAssetState(addAsset: bankSaveSuccess)));
  }
}
