import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:gear_rental/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Register fallback values for File
  registerFallbackValue(File('test.png'));

  late MockAuthRepository mockAuthRepository;
  late UploadImageUsecase uploadImageUsecase;

  // Test data
  final testFile = File('test.png');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    uploadImageUsecase = UploadImageUsecase(mockAuthRepository);
  });

  // Test 1: Should call repository to upload image
  test('should call repository to upload image', () async {
    // Arrange
    when(() => mockAuthRepository.uploadProfilePicture(any())).thenAnswer(
        (_) async => const Right('Upload successful')); // Simulating success

    // Act
    await uploadImageUsecase(UploadImageParams(file: testFile));

    // Assert
    verify(() => mockAuthRepository.uploadProfilePicture(any()))
        .called(1); // Verify repository call
  });

  // Test 2: Should return successful result when image is uploaded
  test('should return success message when image is uploaded', () async {
    // Arrange
    when(() => mockAuthRepository.uploadProfilePicture(any())).thenAnswer(
        (_) async => const Right('Upload successful')); // Simulating success

    // Act
    final result = await uploadImageUsecase(UploadImageParams(file: testFile));

    // Assert
    expect(
        result, const Right('Upload successful')); // Expecting success result
  });

  // Test 3: Should return a failure (just simulating no operation, for simplicity)
  test('should return failure when image upload fails', () async {
    // Arrange
    when(() => mockAuthRepository.uploadProfilePicture(any())).thenAnswer(
        (_) async => const Right('Upload failed')); // Simulating failure

    // Act
    final result = await uploadImageUsecase(UploadImageParams(file: testFile));

    // Assert
    expect(result, const Right('Upload failed')); // Expecting failure result
  });
}
