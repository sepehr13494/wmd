import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_mandates_params.dart';
import '../../data/models/mandate_param.dart';
import '../../domain/use_cases/get_mandates_usecase.dart';
import 'dart:developer';
import 'dart:io';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/jwt_parser.dart';
import '../../data/models/login_pam_account_params.dart';
import '../../domain/use_cases/login_pam_account_usecase.dart';

part 'pam_login_state.dart';

class PamLoginCubit extends Cubit<PamLoginState> {
  final GetPamMandatesUseCase getMandatesUseCase;
  final LoginPamAccountUseCase loginPamAccountUseCase;

  PamLoginCubit(
    this.getMandatesUseCase,
    this.loginPamAccountUseCase,
  ) : super(InitialState());

  getMandates() async {
    emit(LoadingState());
    final result = await getMandatesUseCase(const GetMandatesParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  loginPamAccount() async {
    emit(LoadingState());
    try {
      final auth0 = Auth0(
          AppConstants.pamAuth0IssuerBaseUrl, AppConstants.pamAuth0ClientId);
      late final Credentials credentials;
      if (Platform.isAndroid) {
        credentials = await auth0
            .webAuthentication(scheme: AppConstants.bundleId)
            .login(useEphemeralSession: true);
      } else {
        credentials =
            await auth0.webAuthentication().login(useEphemeralSession: true);
      }
      final claims = parseJwt(credentials.idToken);
      final List<dynamic>? mandates = claims['https://wmd.com/mandate_list'];
      if (mandates == null) {
        emit(ErrorState(
            failure: AppFailure.fromAppException(
                const AppException(message: 'No mandates found'))));
      } else {
        final e = mandates.map((e) => Mandate(e, 'PAM')).toList();
        emit(MandatesLoaded(e));
      }
    } on Exception catch (e) {
      emit(ErrorState(
          failure: AppFailure.fromAppException(AppException(message: '$e'))));
    }
  }

  postMandates(LoginPamAccountParams param) async {
    final result = await loginPamAccountUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
