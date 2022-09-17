import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/presentation/routes/app_router.gr.dart';
import 'package:wmd/core/util/local_storage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LocalStorage localStorage;
  SplashCubit(this.localStorage) : super(SplashInitial());

  initSplash(){
    Future.delayed(const Duration(seconds: 2), () async {
      bool isLogin = await localStorage.getLogin();
      String routeName = "";
      if(isLogin){
        routeName = const LoginRoute().path;
      }else{
        routeName = MainRoute().path;
      }
      emit(SplashLoaded(routeName: routeName));
    },);
  }
}
