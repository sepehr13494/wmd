import 'package:equatable/equatable.dart';
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

// abstract class GetDetailResponse extends Equatable {
//   Map<String, dynamic> toJson();

//   @override
//   List<Object?> get props;
// }
