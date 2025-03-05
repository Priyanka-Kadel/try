import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gear_rental/core/error/failure.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:gear_rental/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final result = await _authRemoteDataSource.getCurrentUser();
      return Right(result);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    try {
      final result = await _authRemoteDataSource.loginUser(username, password);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiFailure(message: "DioException: ${e.message}"));
    } catch (e) {
      return Left(ApiFailure(message: "Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user); // Awaiting the result
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure(message: "DioException: ${e.message}"));
    } catch (e) {
      return Left(ApiFailure(message: "Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } on DioException catch (e) {
      return Left(ApiFailure(message: "DioException: ${e.message}"));
    } catch (e) {
      return Left(ApiFailure(message: "Error: ${e.toString()}"));
    }
  }
}
