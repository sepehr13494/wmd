import '../../domain/entities/get_linked_accounts_entity.dart';

class GetLinkedAccountsResponse  extends GetLinkedAccountsEntity{
    GetLinkedAccountsResponse();

    factory GetLinkedAccountsResponse.fromJson(Map<String, dynamic> json) => GetLinkedAccountsResponse(
    );
    
    static final tResponse = [GetLinkedAccountsResponse()];
}
    