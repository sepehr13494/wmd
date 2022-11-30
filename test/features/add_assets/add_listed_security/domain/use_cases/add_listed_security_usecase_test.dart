import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'add_listed_security_usecase_test.mocks.dart';

@GenerateMocks([ListedSecurityRepository])
void main() {
  late MockListedSecurityRepository mockListedSecurityRepository;
  late AddListedSecurityUseCase addListedSecurityUseCase;

  setUp(() {
    mockListedSecurityRepository = MockListedSecurityRepository();
    addListedSecurityUseCase =
        AddListedSecurityUseCase(mockListedSecurityRepository);
  });

  final tAddResponse = AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from listed security repository',
    () async {
      // arrange
      when(mockListedSecurityRepository.postListedSecurity(
              AddListedSecurityParams.tAddListedSecurityParams))
          .thenAnswer((_) async => Right(tAddResponse));

      // act
      final result = await addListedSecurityUseCase(
          AddListedSecurityParams.tAddListedSecurityMap);
      // assert
      expect(result, Right(tAddResponse));
    },
  );

  test(
    'should get ServerFailure from the listed security repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockListedSecurityRepository.postListedSecurity(
              AddListedSecurityParams.tAddListedSecurityParams))
          .thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result = await addListedSecurityUseCase(
          AddListedSecurityParams.tAddListedSecurityMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
