abstract class GetSeeMoreResponse {
  // GetSeeMoreResponse();

  // factory GetSeeMoreResponse.fromJson(Map<String, dynamic> json) => GetSeeMoreResponse(
  // );

  // static final tResponse = GetSeeMoreResponse();
}

class DefaultMoreEntity extends GetSeeMoreResponse {
  final String json;

  DefaultMoreEntity(this.json);

  toJson() => {'json': json};

  static DefaultMoreEntity tResponse = DefaultMoreEntity('json');
}
