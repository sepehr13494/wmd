import 'package:wmd/core/domain/usecases/usercase.dart';

class GetPieParams extends OwnerIdParams{
  const GetPieParams({required super.ownerId});

  static final tParams = GetPieParams(ownerId: "testId");
    
}
    