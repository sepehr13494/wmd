import '../../domain/entities/get_detail_entity.dart';

class GetDetailResponse extends GetDetailEntity {
  GetDetailResponse();

  factory GetDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetDetailResponse();

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
