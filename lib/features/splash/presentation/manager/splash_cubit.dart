import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/presentation/bloc/base_cubit.dart';
import '../../domain/use_cases/check_login_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckLoginUseCase checkLoginUseCase;
  SplashCubit(this.checkLoginUseCase) : super(SplashInitial());

  Timer? timer;
  bool timerOver = false;
  bool splashReady = false;

  startTimer(){
    timer = Timer(const Duration(seconds: 2), () {
      timerOver = true;
      if(splashReady){
        initSplash(time: 1);
      }
    });
  }

  initSplashFromSplash(){
    splashReady = true;
    if(timerOver){
      initSplash(time: 1);
    }
  }

  initSplash({int time = 2000}) async {
    Future.delayed(
      Duration(milliseconds: time),
      () async {
        final result = await checkLoginUseCase(NoParams());
        result.fold(
            (l) => emit(ErrorState(
                failure: l,
                tryAgainFunction: () {
                  initSplash();
                })), (r) {
          emit(SplashLoaded(isLogin: r));
        });
      },
    );
  }

  @override
  Future<void> close() {
    if(timer != null){
      timer!.cancel();
    }
    return super.close();
  }
}
