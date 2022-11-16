import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'base_cubit.dart';
import '../widgets/loading_widget.dart';
import '../../util/loading/loading_screen.dart';

class BlocHelper {
  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
  }) {
    return (context, state) {
      if (state is LoadingState) {
        LoadingOverlay().show(context: context, text: state.message);
      } else if (state is ErrorState) {
        LoadingOverlay().hide();
        // GlobalFunctions.showSnackBar(context, state.failure.message,
        //     color: Colors.red[800], type: "error");
        if (state.failure is ServerFailure) {
          switch ((state.failure as ServerFailure).type) {
            case ServerExceptionType.normal:
            case ServerExceptionType.unExpected:
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
                GlobalFunctions.showSnackBar(context, state.failure.message,
                    color: Colors.red[800], type: "error");
              }

              break;
            case ServerExceptionType.auth:
              GlobalFunctions.showSnackBar(context, state.failure.message);
              sl<LocalStorage>().logout();
              context.replaceNamed(AppRoutes.splash);
              break;
          }
        }
      }
      else {
        LoadingOverlay().hide();
        listener(context, state);
      }
    };
  }

  static BlocWidgetBuilder defaultBlocBuilder({
    required BlocWidgetBuilder builder,
  }) {
    return (context, state) {
      if (state is LoadingState) {
        return const LoadingWidget();
      } else {
        return builder(context, state);
      }
    };
  }
}
