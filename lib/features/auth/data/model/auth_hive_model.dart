// part 'auth_hive_model.g.dart';
import 'package:equatable/equatable.dart';
import 'package:gear_rental/app/constatns/hive_table_constants.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String? image;

  AuthHiveModel({
    String? userId,
    required this.username,
    required this.email,
    required this.password,
    this.image,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        username = '',
        email = '',
        password = '',
        image = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      image: entity.image,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      username: username,
      email: email,
      password: password,
      image: image,
    );
  }

  @override
  List<Object?> get props => [userId, username, email, password, image];
}
