import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gear_rental/app/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String username;
  final String email;
  final String? image;
  final String password;

  const RegisterUserParams({
    required this.username,
    required this.email,
    this.image,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.username,
    required this.email,
    this.image,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, image, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      username: params.username,
      email: params.email,
      image: params.image,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
