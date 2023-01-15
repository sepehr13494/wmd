import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/asset_summary_entity.dart';
import 'package:wmd/features/asset_detail/core/domain/use_cases/get_summary_usecase.dart';

part 'asset_summary_state.dart';

class AssetSummaryCubit extends Cubit<AssetSummaryState> {
  final GetSummaryUseCase getSummaryUseCase;

  AssetSummaryCubit(
    this.getSummaryUseCase,
  ) : super(LoadingState());

  getSummary(GetSummaryParams param) async {
    emit(LoadingState());
    final result = await getSummaryUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entity) => emit(AssetLoaded(entity)));
  }
}
