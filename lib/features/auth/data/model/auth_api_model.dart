import 'package:equatable/equatable.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  final String username;
  final String email;
  final String? password;
  final String? image;

  const AuthApiModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.image,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      username: username,
      email: email,
      password: password ?? '',
      image: image,
    );
  }

  //From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      username: entity.username,
      email: entity.email,
      password: entity.password,
      image: entity.image,
    );
  }

  @override
  // List<Object?> get props => throw UnimplementedError();
  List<Object?> get props => [id, username, email, password, image];
}
