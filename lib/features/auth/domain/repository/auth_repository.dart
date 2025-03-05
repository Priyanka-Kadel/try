// lib/features/auth/domain/repository/auth_repository.dart
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gear_rental/core/error/failure.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
