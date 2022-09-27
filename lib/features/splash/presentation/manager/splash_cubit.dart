import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/presentation/bloc/base_cubit.dart';
import '../../../../core/presentation/routes/app_routes.dart';
import '../../domain/use_cases/check_login_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckLoginUseCase checkLoginUseCase;
  SplashCubit(this.checkLoginUseCase) : super(SplashInitial());

  initSplash() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final result = await checkLoginUseCase(NoParams());
        result.fold(
            (l) => emit(ErrorState(
                failure: l,
                tryAgainFunction: () {
                  initSplash();
                })), (r) {
          String routeName = "";
          if (r) {
            routeName = AppRoutes.main;
          } else {
            routeName = AppRoutes.verifyEmail;
          }
          emit(SplashLoaded(routeName: routeName));
        });
      },
    );
  }
}
