import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart';

class MinMaxCalculator{
  static List<double> calculateMinyMaxY(List<GetAllocationEntity> allocations, bool isOneData) {
    double minY = 0;
    double maxY = 0;
    if(allocations.isNotEmpty){
      if(!isOneData || allocations.first.netWorth < 0){
        minY = allocations[0].netWorth;
        for (var element in allocations) {
          if(element.netWorth<minY){
            minY = element.netWorth;
          }
        }
        if(minY > 0){
          minY = 0;
        }
      }
    }
    if(allocations.isNotEmpty){
      if(!isOneData || allocations.first.netWorth > 0){
        maxY = allocations[0].netWorth;
        for (var element in allocations) {
          if(element.netWorth>maxY){
            maxY = element.netWorth;
          }
        }
        if(maxY < 0){
          maxY = 0;
        }
      }
    }
    return [minY,maxY];
  }
}