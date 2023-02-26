import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';

class ChartChooserManager extends Cubit<AllChartType?>{
  ChartChooserManager() : super(null);

  changeChart(AllChartType allChartType){
    emit(allChartType);
  }
}

class GetChartChooserManager extends ChartChooserManager{}