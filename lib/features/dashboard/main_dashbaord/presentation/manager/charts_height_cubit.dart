import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsHeightCubit extends Cubit<NewChartsHeight> {
  ChartsHeightCubit() : super(NewChartsHeight(0));

  setLength(int newLength) {
    emit(NewChartsHeight(newLength));
  }
}

class NewChartsHeight {
  final int length;

  NewChartsHeight(this.length);
}
