import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gear_rental/core/error/failure.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_data_source.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:gear_rental/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  AuthLocalRepository(this._authDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authDataSource.getCurrentUser();
      return Right(user); // Return the user data wrapped in a Right (success)
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: e.toString())); // Return failure in case of error
    }
  }

  // @override
  // Future<Either<Failure, List<ProductEntity>>> getProducts() async {
  //   try {
  //     final user = await _authDataSource.getProducts();
  //     return Right(user); // Return the user data wrapped in a Right (success)
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(
  //         message: e.toString())); // Return failure in case of error
  //   }
  // }

  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    try {
      final result = await _authDataSource.loginUser(username, password);
      return Right(result); // Return the success message wrapped in Right
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: e.toString())); // Return failure in case of error
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authDataSource.registerUser(user);
      return const Right(null); // Return success (no value) in Right
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: e.toString())); // Return failure in case of error
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final result = await _authDataSource.uploadProfilePicture(file);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
