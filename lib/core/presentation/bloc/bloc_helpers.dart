import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/global_functions.dart';
import 'base_cubit.dart';
import '../widgets/loading_widget.dart';
import '../../util/loading/loading_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlocHelper {
  static convertErrorMsg(BuildContext context, String msg) {
    var errorMsg = msg;
    switch (msg) {
      case "Invalid email or password, Please try again.":
        errorMsg = AppLocalizations.of(context).auth_login_toast_error_title;
        break;
      case "Please try again shortly, we are experiencing difficulties":
        errorMsg =
            AppLocalizations.of(context).auth_login_toast_error_unexpected;
        break;

      default:
        errorMsg = msg;
        break;
    }

    return errorMsg;
  }

  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
  }) {
    return (context, state) {
      if (state is LoadingState) {
        LoadingOverlay().show(context: context, text: state.message);
      } else if (state is ErrorState) {
        LoadingOverlay().hide();
        if (state.failure is ServerFailure) {
          debugPrint(state.failure.data.toString());
          switch ((state.failure as ServerFailure).type) {
            case ExceptionType.normal:
            case ExceptionType.format:
            case ExceptionType.unExpected:
              if (state.tryAgainFunction != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(state.failure.message),
                                state.tryAgainFunction == null
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          if (state.tryAgainFunction != null) {
                                            Navigator.pop(context);
                                            state.tryAgainFunction!();
                                          }
                                        },
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("tryAgain")),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                GlobalFunctions.showSnackBar(
                    context,
                    state.failure.type == ExceptionType.unExpected
                        ? AppLocalizations.of(context)
                            .common_errors_somethingWentWrong
                        : convertErrorMsg(context, state.failure.message),
                    color: Colors.red[800],
                    type: "error");
              }
              break;
            case ExceptionType.auth:
              GlobalFunctions.showSnackBar(context,
                  AppLocalizations.of(context).auth_login_toast_wrongToken);
              AppRestart.restart(context);
              break;
          }
        } else {
          debugPrint(state.failure.data.toString());
          debugPrint(state.failure.stackTrace.toString());
          GlobalFunctions.showSnackBar(context, state.failure.message,
              color: Colors.red[800], type: "error");
        }
      } else {
        if (state is SuccessState) {
          debugPrint(state.appSuccess.message);
        }
        LoadingOverlay().hide();
        listener(context, state);
      }
    };
  }

  static BlocWidgetBuilder errorHiderBlocBuilder({
    required BlocWidgetBuilder builder,
  }) {
    return (context, state) {
      if (state is ErrorState) {
        return const SizedBox();
      } else {
        return builder(context, state);
      }
    };
  }
}
