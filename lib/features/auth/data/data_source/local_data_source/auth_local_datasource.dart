// lib/features/auth/data/data_source/local_data_source/auth_local_datasource.dart
import 'dart:io';

import 'package:gear_rental/core/network/hive_service.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_data_source.dart';
import 'package:gear_rental/features/auth/data/model/auth_hive_model.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity or actual user data from Hive
    return Future.value(const AuthEntity(
      userId: "1", // Just an example, you'd fetch this from Hive
      username: "",
      email: "",
      password: "",
    ));
  }

  // @override
  // Future<List<ProductEntity>> getProducts() {
  //   // Return Empty AuthEntity or actual user data from Hive
  //   return Future.value([
  //     const ProductEntity(
  //       productId: "1", // Just an example, you'd fetch this from Hive
  //       name: '',
  //       price: '',
  //       image: '',
  //       quantity: '',
  //     )
  //   ]);
  // }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e); // Return the error if login fails
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _hiveService.register(authHiveModel); // Save user data to Hive
      return Future.value();
    } catch (e) {
      return Future.error(e); // Return error if registration fails
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
