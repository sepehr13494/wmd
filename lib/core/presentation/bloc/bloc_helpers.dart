import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      } else {
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
