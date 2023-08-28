import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioVisibleController extends Cubit<bool>{
  PortfolioVisibleController() : super(false);

  changeVisibility({required bool visible}){
    emit(visible);
  }
}