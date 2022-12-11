import '../../domain/entities/get_allocation_entity.dart';

class GetAllocationResponse  extends GetAllocationEntity{
    GetAllocationResponse();

    factory GetAllocationResponse.fromJson(Map<String, dynamic> json) => GetAllocationResponse(
    );

    static final tResponse = [GetAllocationResponse()];
}
    