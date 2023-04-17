import 'package:flutter_bloc/flutter_bloc.dart';

class TabManager extends Cubit<int>{
  TabManager() : super(0);

  changeTab(index){
    if(state != index){
      emit(index);
    }
  }

}

class TabScrollManager extends Cubit<int?>{
  TabScrollManager() : super(null);

  changeIndex(int? index){
    emit(index);
  }
}