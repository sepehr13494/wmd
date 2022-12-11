import 'package:wmd/core/domain/usecases/usercase.dart';

class GetAllocationParams extends OwnerIdParams{
  const GetAllocationParams({required super.ownerId});

  static final tParams = GetAllocationParams(ownerId: "testId");
}
    