import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/global_functions.dart';
import 'base_cubit.dart';
import '../widgets/loading_widget.dart';
import '../../util/loading/loading_screen.dart';

class BlocHelper {
  BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
  }) {
    return (context, state) {
      if (state is LoadingState) {
        LoadingOverlay().show(context: context, text: state.message);
      } else if (state is ErrorState) {
        LoadingOverlay().hide();
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: InkWell(
                    onTap: () {
                      if (state.tryAgainFunction != null) {
                        Navigator.pop(context);
                        state.tryAgainFunction!();
                      }
                    },
                    child: Text("tryAgain"),
                  ),
                ),
              );
            });
      }
      // else if (state is SuccessState) {
      //   //showing a snackbar that it is successful
      //   GlobalFunctions.showSnackBar(
      //     context,
      //     state.appSuccess.message,
      //     color: Colors.green,
      //   );
      // }
      else {
        LoadingOverlay().hide();
        listener(context, state);
      }
    };
  }

  BlocWidgetBuilder defaultBlocBuilder({
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
