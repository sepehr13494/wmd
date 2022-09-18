import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

class AppDefaultBlocListener<B extends StateStreamable<S>, S>
    extends BlocListenerBase<B, S>{

  AppDefaultBlocListener({
    Key? key,
    required BlocWidgetListener<S> listener,
    B? bloc,
    BlocListenerCondition<S>? listenWhen,
    Widget? child,
  }) : super(
    key: key,
    child: child,
    listener: (context,state){
      if(state is LoadingState){

      }else if(state is ErrorState){
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: InkWell(
                    onTap: (){
                      if(state.tryAgainFunction != null){
                        Navigator.pop(context);
                        state.tryAgainFunction!();
                      }
                    },
                    child: Text("tryAgain"),
                  ),
                ),
              );
            });
      }else{
        listener(context,state);
      }
    },
    bloc: bloc,
    listenWhen: listenWhen,
  );
}
