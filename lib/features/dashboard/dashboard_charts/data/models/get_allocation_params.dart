import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

class GetAllocationParams extends OwnerIdParams{
  final String? to;
  const GetAllocationParams(
  {required String ownerId,required this.to}
      ) : super(ownerId: ownerId);

  static final tParams = GetAllocationParams(ownerId: "testId",to: CustomizableDateTime.currentDate);
}
    