import '../../domain/entities/post_valuation_entity.dart';

class PostValuationResponse  extends PostValuationEntity{
    PostValuationResponse();

    factory PostValuationResponse.fromJson(Map<String, dynamic> json) => PostValuationResponse(
    );
    
    static final tResponse = PostValuationResponse();
}
    