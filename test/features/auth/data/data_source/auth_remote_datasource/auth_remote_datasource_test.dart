import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/app/constatns/api_endpoints.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthRemoteDataSource authRemoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authRemoteDataSource = AuthRemoteDataSource(mockDio);
  });

  group('AuthRemoteDataSource Tests', () {
    test('should register user successfully', () async {
      const user = AuthEntity(
        username: 'testUser',
        email: 'test@test.com',
        password: 'password123',
      );

      when(() => mockDio.post(
            ApiEndpoints.baseUrl + ApiEndpoints.register,
            data: any(named: 'data'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ApiEndpoints.register),
          statusCode: 200,
        ),
      );

      // Call the method
      await authRemoteDataSource.registerUser(user);

      verify(() => mockDio.post(
            ApiEndpoints.baseUrl + ApiEndpoints.register,
            data: {
              "username": user.username,
              "image": user.image,
              "email": user.email,
              "password": user.password,
            },
          )).called(1);
    });

    test('should throw error when registration fails', () async {
      const user = AuthEntity(
        username: 'testUser',
        email: 'test@test.com',
        password: 'password123',
      );

      when(() => mockDio.post(
                ApiEndpoints.baseUrl + ApiEndpoints.register,
                data: any(named: 'data'),
              ))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.register)));

      expect(() => authRemoteDataSource.registerUser(user),
          throwsA(isA<Exception>()));
    });

    test('should throw error when profile picture upload fails', () async {
      final file = File('test_image.png');

      when(() => mockDio.post(
                ApiEndpoints.baseUrl + ApiEndpoints.uploadImage,
                data: any(named: 'data'),
              ))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.uploadImage)));

      expect(() => authRemoteDataSource.uploadProfilePicture(file),
          throwsA(isA<Exception>()));
    });

    test('should login user successfully and return token', () async {
      const username = 'testUser';
      const password = 'password123';

      when(() => mockDio.post(
            ApiEndpoints.baseUrl + ApiEndpoints.login,
            data: any(named: 'data'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ApiEndpoints.login),
          statusCode: 200,
          data: {'token': 'some_token'},
        ),
      );

      final token = await authRemoteDataSource.loginUser(username, password);

      expect(token, 'some_token');
    });

    test('should throw error when login fails', () async {
      const username = 'testUser';
      const password = 'password123';

      when(() => mockDio.post(
                ApiEndpoints.baseUrl + ApiEndpoints.login,
                data: any(named: 'data'),
              ))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: ApiEndpoints.login)));

      expect(() => authRemoteDataSource.loginUser(username, password),
          throwsA(isA<Exception>()));
    });
  });
}
