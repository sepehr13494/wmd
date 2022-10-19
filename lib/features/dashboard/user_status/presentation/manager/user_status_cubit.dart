import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/put_user_status_usecase.dart';

part 'user_status_state.dart';

class UserStatusCubit extends Cubit<UserStatusState> {
  final GetUserStatusUseCase getUserStatusUseCase;
  final PutUserStatusUseCase putUserStatusUseCase;
  UserStatusCubit(this.getUserStatusUseCase, this.putUserStatusUseCase)
      : super(LoadingState());

  getUserStatus() async {
    emit(LoadingState());
    final result = await getUserStatusUseCase(NoParams());
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (userStatusSuccess) => {
              userStatusSuccess.loginAt ??
                  postUserStatus(map: {
                    "email": userStatusSuccess.email,
                    "loginAt": CustomizableDateTime.currentDate
                  }),
              emit(UserStatusLoaded(userStatus: userStatusSuccess)),
            });
  }

  postUserStatus({required Map<String, dynamic> map}) async {
    final result = await putUserStatusUseCase(UserStatus.fromJson(map));
    result.fold((failure) => {}, (userStatusSuccess) => {});
  }
}
