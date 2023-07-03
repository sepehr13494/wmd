import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:nonce/nonce.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/jwt_parser.dart';
import 'package:wmd/features/add_assets/pam_login/data/models/mandate_param.dart';

import '../../data/models/get_mandates_params.dart';
import '../../domain/use_cases/get_mandates_usecase.dart';

import '../../data/models/login_tfo_account_params.dart';
import '../../domain/use_cases/login_tfo_account_usecase.dart';

part 'tfo_login_state.dart';

class TfoLoginCubit extends Cubit<TfoLoginState> {
  final GetMandatesUseCase getMandatesUseCase;
  final LoginTfoAccountUseCase loginTfoAccountUseCase;

  TfoLoginCubit(
    this.getMandatesUseCase,
    this.loginTfoAccountUseCase,
  ) : super(InitialState());

  getMandates() async {
    emit(LoadingState());
    final result = await getMandatesUseCase(const GetMandatesParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  loginTfoAccount() async {
    emit(LoadingState());

    try {
      final url = getMandatesConnectUrl(Nonce.generate(16));
      final result = await FlutterWebAuth2.authenticate(
          url: url,
          callbackUrlScheme: AppConstants.bundleId,
          preferEphemeral: true);
      final uri = Uri.parse(result);
      if (!uri.hasFragment) {
        emit(ErrorState(
            failure: AppFailure.fromAppException(
                const AppException(message: 'No mandates found'))));
      }
      late final String token;
      try {
        token = uri.fragment.split('=').last;
      } on Exception catch (e) {
        emit(ErrorState(
            failure: AppFailure.fromAppException(
                const AppException(message: 'No mandates found'))));
      }

      final claims = parseJwt(token);
      final List<dynamic>? mandates = claims['https://wmd.com/mandate_list'];
      if (mandates == null) {
        emit(ErrorState(
            failure: AppFailure.fromAppException(
                const AppException(message: 'No mandates found'))));
      } else {
        final e = mandates.map((e) => Mandate(e, 'TFO')).toList();
        emit(TfoMandatesLoaded(e));
      }
    } on Exception catch (e) {
      emit(ErrorState(
          failure: AppFailure.fromAppException(AppException(message: '$e'))));
    }
  }

  postMandates(LoginTfoAccountParams param) async {
    final result = await loginTfoAccountUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}

String getMandatesConnectUrl(String nonce) {
  final String redirection = Platform.isAndroid
      ? AppConstants.tfoAuth0RedirectionAndroid
      : AppConstants.tfoAuth0RedirectionIos;
  final str =
      "${AppConstants.tfoAuth0IssuerBaseUrl}/authorize?response_type=id_token&client_id=${AppConstants.tfoAuth0ClientId}&redirect_uri=$redirection&scope=openid&nonce=$nonce&audience=${AppConstants.tfoAuth0Audience}";
  return Uri.parse(str).toString();
}
