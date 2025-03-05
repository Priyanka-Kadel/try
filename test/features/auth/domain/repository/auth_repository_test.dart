import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../use_case/login_usecase_test.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthEntity testUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    testUser = const AuthEntity(
      userId: '123',
      image: 'test_image.jpg',
      username: 'testUser',
      email: 'test@example.com',
      password: 'password123',
    );
  });

  group('Auth Repository Tests', () {
    test('should register user successfully', () async {
      // Arrange
      when(() => mockAuthRepository.registerUser(testUser))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = mockAuthRepository.registerUser(testUser);

      // Assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.registerUser(testUser)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should login successfully and return user ID', () async {
      // Arrange
      when(() => mockAuthRepository.loginUser('testUser', 'password123'))
          .thenAnswer((_) async => const Right('123'));

      // Act
      final result =
          await mockAuthRepository.loginUser('testUser', 'password123');

      // Assert
      expect(result, const Right('123'));
      verify(() => mockAuthRepository.loginUser('testUser', 'password123'))
          .called(1);
    });

    test('should upload profile picture successfully', () async {
      // Arrange
      final file = File('test.jpg');
      when(() => mockAuthRepository.uploadProfilePicture(file))
          .thenAnswer((_) async => const Right('uploaded_url'));

      // Act
      final result = mockAuthRepository.uploadProfilePicture(file);

      // Assert
      expect(result, const Right('uploaded_url'));
      verify(() => mockAuthRepository.uploadProfilePicture(file)).called(1);
    });

    test('should return current user data', () async {
      // Arrange
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => Right(testUser));

      // Act
      final result = mockAuthRepository.getCurrentUser();

      // Assert
      expect(result, Right(testUser));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });
  });
}
