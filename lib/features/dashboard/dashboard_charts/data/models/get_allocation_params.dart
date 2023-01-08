import 'owner_id_model.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

class GetAllocationParams extends OwnerIdParams {
  final String? to;
  final String? from;

  const GetAllocationParams({
    required String ownerId,
    required this.to,
    required this.from,
  }) : super(ownerId: ownerId);

  static final tParams = GetAllocationParams(
      ownerId: "testId", from: CustomizableDateTime.currentDate,to: CustomizableDateTime.currentDate);
}
