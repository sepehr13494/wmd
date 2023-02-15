import '../../domain/entities/get_currency_entity.dart';

class GetCurrencyResponse  extends GetCurrencyEntity{
    GetCurrencyResponse();

    factory GetCurrencyResponse.fromJson(Map<String, dynamic> json) => GetCurrencyResponse(
    );
    
    static final tResponse = [GetCurrencyResponse()];
}
    