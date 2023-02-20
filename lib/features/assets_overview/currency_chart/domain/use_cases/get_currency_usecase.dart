import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';


import '../../data/models/get_currency_params.dart';
import '../entities/get_currency_entity.dart';
import '../repositories/currency_chart_repository.dart';

class GetCurrencyUseCase extends UseCase<List<GetCurrencyEntity>, NoParams> {
  final CurrencyChartRepository repository;
  final LocalStorage localStorage;

  GetCurrencyUseCase(this.repository, this.localStorage);
  @override
  Future<Either<Failure, List<GetCurrencyEntity>>> call(NoParams params) async{
    try{
      final result = await repository.getCurrency(GetCurrencyParams(userId: localStorage.getOwnerId()));
      late Either<Failure, List<GetCurrencyEntity>> finalResult;
      result.fold((l) => finalResult = Left(l), (r) {
        List<GetCurrencyEntity> finalList = [];
        r.sort((a, b) => (b.totalAmount - a.totalAmount).toInt(),);
        if(r.length > 8){
          for(int i=0 ; i<7 ; i++){
            finalList.add(r[i]);
          }
          double sum = 0;
          for(int i=7 ; i<r.length ; i++){
            sum += r[i].totalAmount;
          }
          final otherEntity = GetCurrencyEntity(currencyCode: "Other", totalAmount: sum, assetList: const [], yearToDate: 0, inceptionToDate: 0);
          finalList.add(otherEntity);
        }else{
          finalList = r;
        }
        return finalResult = Right(finalList);
      });
      return finalResult;
    } catch (e){
      return Left(AppFailure(message: "getCurrency failed",data: e.toString(),stackTrace: e is TypeError ? e.stackTrace : null));
    }
  }
}


    