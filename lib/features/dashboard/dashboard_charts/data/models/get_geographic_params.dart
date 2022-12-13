import 'package:wmd/core/domain/usecases/usercase.dart';

class GetGeographicParams extends OwnerIdParams{
  const GetGeographicParams({required super.ownerId});

  static const tParams = GetGeographicParams(ownerId: "testId");
    
}
    