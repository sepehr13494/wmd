import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_params.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_response.dart';
import 'package:wmd/features/force_update/domain/use_cases/get_force_update_usecase.dart';


import '../../data/repositories/force_update_repository_impl_test.mocks.dart';
import 'get_force_update_usecase_test.mocks.dart';



@GenerateMocks([
  PackageInfo,

])
void main() {
  late GetForceUpdateUseCase getForceUpdateUseCase;
  late MockForceUpdateRepository mockForceUpdateRepository;
  late MockPackageInfo mockPackageInfo;

  final tPackageName = GetForceUpdateParams.tParams.versionName;
  final tPackageNumber = GetForceUpdateParams.tParams.versionNumber;

  setUp(() {
    mockForceUpdateRepository = MockForceUpdateRepository();
    mockPackageInfo = MockPackageInfo();
    getForceUpdateUseCase = GetForceUpdateUseCase(mockForceUpdateRepository,mockPackageInfo);
  });

  test('should get GetForceUpdateEntity from the repository', () async {
    //arrange
    when(mockForceUpdateRepository.getForceUpdate(any))
        .thenAnswer((_) async => const Right(GetForceUpdateResponse.tResponse));
    when(mockPackageInfo.version)
        .thenAnswer((_) => tPackageName);
    when(mockPackageInfo.buildNumber)
        .thenAnswer((_) => tPackageNumber);
    // act
    final result = await getForceUpdateUseCase(NoParams());

    // assert
    expect(result, equals(const Right(GetForceUpdateResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockForceUpdateRepository.getForceUpdate(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockPackageInfo.version)
          .thenAnswer((_) => tPackageName);
      when(mockPackageInfo.buildNumber)
          .thenAnswer((_) => tPackageNumber);
      //act
      final result = await getForceUpdateUseCase(NoParams());
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockForceUpdateRepository.getForceUpdate(GetForceUpdateParams.tParams));
    },
  );
}

    