import '../../domain/entities/get_allocation_entity.dart';

class GetAllocationResponse  extends GetAllocationEntity{
    const GetAllocationResponse({
       required String name,
       required double asset,
       required double liability,
       required double netWorth,
    }) : super(
        name : name,
        asset : asset,
        liability : liability,
        netWorth : netWorth,
    );

    factory GetAllocationResponse.fromJson(Map<String, dynamic> json) => GetAllocationResponse(
        name: json["name"]??".",
        asset: double.tryParse(json["asset"].toString())??0,
        liability: double.tryParse(json["liability"].toString())??0,
        netWorth: double.tryParse(json["netWorth"].toString())??0,
    );

    static const tResponse = [GetAllocationResponse(name: "tName",asset: 100,liability: 0,netWorth: 100)];
}
    