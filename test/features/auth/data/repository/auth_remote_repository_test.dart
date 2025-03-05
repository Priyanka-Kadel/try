import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/core/error/failure.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:gear_rental/features/auth/data/repository/auth_remote_repository.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

// Mock AuthRemoteDataSource
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteRepository authRemoteRepository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRemoteRepository = AuthRemoteRepository(mockAuthRemoteDataSource);
  });

  group('AuthRemoteRepository Tests', () {
    test('loginUser should return Right with token on success', () async {
      // Arrange
      const username = 'testUser';
      const password = 'password';
      const token = 'sampleToken';

      when(() => mockAuthRemoteDataSource.loginUser(username, password))
          .thenAnswer((_) async => token);

      // Act
      final result = await authRemoteRepository.loginUser(username, password);

      // Assert
      expect(result, const Right(token));
      verify(() => mockAuthRemoteDataSource.loginUser(username, password))
          .called(1);
    });

    test('loginUser should return Left with ApiFailure on error', () async {
      // Arrange
      const username = 'testUser';
      const password = 'password';
      final exception = DioException(
          message: 'Login failed', requestOptions: RequestOptions(path: ''));

      when(() => mockAuthRemoteDataSource.loginUser(username, password))
          .thenThrow(exception);

      // Act
      final result = await authRemoteRepository.loginUser(username, password);

      // Assert
      expect(result,
          Left(ApiFailure(message: 'DioException: ${exception.message}')));
      verify(() => mockAuthRemoteDataSource.loginUser(username, password))
          .called(1);
    });

    test('registerUser should return Right with null on success', () async {
      // Arrange
      const user = AuthEntity(
          username: 'testUser',
          email: 'test@example.com',
          password: 'password');

      when(() => mockAuthRemoteDataSource.registerUser(user))
          .thenAnswer((_) async {});

      // Act
      final result = await authRemoteRepository.registerUser(user);

      // Assert
      expect(result, const Right(null));
      verify(() => mockAuthRemoteDataSource.registerUser(user)).called(1);
    });

    test('registerUser should return Left with ApiFailure on error', () async {
      // Arrange
      const user = AuthEntity(
          username: 'testUser',
          email: 'test@example.com',
          password: 'password');
      final exception = DioException(
          message: 'Registration failed',
          requestOptions: RequestOptions(path: ''));

      when(() => mockAuthRemoteDataSource.registerUser(user))
          .thenThrow(exception);

      // Act
      final result = await authRemoteRepository.registerUser(user);

      // Assert
      expect(result,
          Left(ApiFailure(message: 'DioException: ${exception.message}')));
      verify(() => mockAuthRemoteDataSource.registerUser(user)).called(1);
    });

    test('uploadProfilePicture should return Right with image name on success',
        () async {
      // Arrange
      final file = File('image.png');
      const imageName = 'uploaded_image.png';

      when(() => mockAuthRemoteDataSource.uploadProfilePicture(file))
          .thenAnswer((_) async => imageName);

      // Act
      final result = await authRemoteRepository.uploadProfilePicture(file);

      // Assert
      expect(result, const Right(imageName));
      verify(() => mockAuthRemoteDataSource.uploadProfilePicture(file))
          .called(1);
    });

    test('uploadProfilePicture should return Left with ApiFailure on error',
        () async {
      // Arrange
      final file = File('image.png');
      final exception = DioException(
          message: 'Image upload failed',
          requestOptions: RequestOptions(path: ''));

      when(() => mockAuthRemoteDataSource.uploadProfilePicture(file))
          .thenThrow(exception);

      // Act
      final result = await authRemoteRepository.uploadProfilePicture(file);

      // Assert
      expect(result,
          Left(ApiFailure(message: 'DioException: ${exception.message}')));
      verify(() => mockAuthRemoteDataSource.uploadProfilePicture(file))
          .called(1);
    });

    test('getCurrentUser should return Right with AuthEntity on success',
        () async {
      // Arrange
      const authEntity = AuthEntity(
          username: 'testUser',
          email: 'test@example.com',
          password: 'password');

      when(() => mockAuthRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => authEntity);

      // Act
      final result = await authRemoteRepository.getCurrentUser();

      // Assert
      expect(result, const Right(authEntity));
      verify(() => mockAuthRemoteDataSource.getCurrentUser()).called(1);
    });

    test('getCurrentUser should return Left with ApiFailure on error',
        () async {
      // Arrange
      final exception = Exception('Failed to get current user');

      when(() => mockAuthRemoteDataSource.getCurrentUser())
          .thenThrow(exception);

      // Act
      final result = await authRemoteRepository.getCurrentUser();

      // Assert
      expect(result, Left(ApiFailure(message: exception.toString())));
      verify(() => mockAuthRemoteDataSource.getCurrentUser()).called(1);
    });
  });
}
