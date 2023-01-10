import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';

part 'main_dashboard_state.dart';

class MainDashboardCubit extends Cubit<MainDashboardState> {
  final UserNetWorthUseCase userNetWorthUseCase;

  MainDashboardCubit(this.userNetWorthUseCase) : super(LoadingState());

  TimeFilterObj? dateTimeRange;

  initPage() {
    getNetWorth(dateTimeRange: dateTimeRange);
  }

  getNetWorth({TimeFilterObj? dateTimeRange}) async {
    if (dateTimeRange != null) {
      this.dateTimeRange = dateTimeRange;
    }
    emit(LoadingState());
    final result = await userNetWorthUseCase(dateTimeRange);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (userNetWorth) {
      emit(MainDashboardNetWorthLoaded(netWorthObj: userNetWorth));
    });
  }
}
