// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:gear_rental/app/constatns/api_endpoints.dart';
// import 'package:gear_rental/features/auth/data/data_source/auth_data_source.dart';
// import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthRemoteDataSource implements IAuthDataSource {
//   final Dio _dio;

//   AuthRemoteDataSource(this._dio);

//   @override
//   Future<void> registerUser(AuthEntity user) async {
//     try {
//       Response response = await _dio.post(
//         ApiEndpoints.baseUrl + ApiEndpoints.register,
//         data: {
//           "fName": user.username,
//           "image": user.image,
//           "email": user.email,
//           "password": user.password,
//         },
//       );

//       if (response.statusCode == 200) {
//         return;
//       } else {
//         throw Exception("Failed to register user: ${response.statusMessage}");
//       }
//     } on DioException catch (e) {
//       throw Exception("DioException: ${e.message}");
//     } catch (e) {
//       throw Exception("Unknown Error: ${e.toString()}");
//     }
//   }

//   @override
//   Future<String> uploadProfilePicture(File file) async {
//     try {
//       FormData formData = FormData.fromMap({
//         "image": await MultipartFile.fromFile(file.path),
//       });

//       Response response = await _dio.post(
//         ApiEndpoints.baseUrl + ApiEndpoints.uploadImage,
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         return response.data['image'];
//       } else {
//         throw Exception("Failed to upload image: ${response.statusMessage}");
//       }
//     } catch (e) {
//       throw Exception("Image Upload Error: ${e.toString()}");
//     }
//   }

//   @override
//   Future<String> loginUser(String username, String password) async {
//     try {
//       Response response =
//           await _dio.post(ApiEndpoints.baseUrl + ApiEndpoints.login, data: {
//         "email": username,
//         "password": password,
//       });

//       if (response.statusCode == 200) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', response.data['token']);
//         return response.data['token'];
//       } else {
//         throw Exception("Failed to login: ${response.statusMessage}");
//       }
//     } catch (e) {
//       throw Exception("Login Error: ${e.toString()}");
//     }
//   }

//   @override
// //   Future<AuthEntity> getCurrentUser() async {
// //     try {
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       String token = prefs.getString('token') ?? '';

// //       Response response =
// //           await _dio.get(ApiEndpoints.baseUrl + ApiEndpoints.getCustomer,
// //               options: Options(headers: {
// //                 HttpHeaders.authorizationHeader: "Bearer $token",
// //               }));

// //       if (response.statusCode == 200) {
// //         return response.data['token'];
// //       } else {
// //         throw Exception("Failed to login: ${response.statusMessage}");
// //       }
// //     } catch (e) {
// //       throw Exception("Login Error: ${e.toString()}");
// //     }
// //   }
// // }
//   @override
//   Future<AuthEntity> getCurrentUser() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('token') ?? '';

//       Response response = await _dio.get(
//         ApiEndpoints.baseUrl + ApiEndpoints.getCustomer,
//         options: Options(headers: {
//           HttpHeaders.authorizationHeader: "Bearer $token",
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data; // Extract user data
//         // log data to the console flutter
//         print('object');
//         print(data['data']);
//         return AuthEntity(
//           userId: data['data']['_id'],
//           image: data['data']['image'] ?? '',
//           username: data['data']['fName'],
//           email: data['data']['email'],
//           password: '', // Leave blank since it's not returned from API
//         );
//       } else {
//         throw Exception("Failed to fetch user: ${response.statusMessage}");
//       }
//     } catch (e) {
//       throw Exception("User Fetch Error: ${e.toString()}");
//     }
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gear_rental/app/constatns/api_endpoints.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_data_source.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.register,
        data: {
          "fName": user.username,
          "image": user.image,
          "email": user.email,
          "password": user.password,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to register user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("DioException: ${e.message}");
    } catch (e) {
      throw Exception("Unknown Error: ${e.toString()}");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path),
      });

      Response response = await _dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['image'];
      } else {
        throw Exception("Failed to upload image: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Image Upload Error: ${e.toString()}");
    }
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      Response response =
          await _dio.post(ApiEndpoints.baseUrl + ApiEndpoints.login, data: {
        "email": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
        return response.data['token'];
      } else {
        throw Exception("Failed to login: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Login Error: ${e.toString()}");
    }
  }

  @override
  Future<List<dynamic>> getProducts() async {
    try {
      Response response = await _dio.get('${ApiEndpoints.baseUrl}products');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to login: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Login Error: ${e.toString()}");
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      Response response = await _dio.get(
        ApiEndpoints.baseUrl + ApiEndpoints.getCustomer,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data; // Extract user data
        // log data to the console flutter
        return AuthEntity(
          userId: data['data']['_id'],
          image: data['data']['image'] ?? '',
          username: data['data']['fName'],
          email: data['data']['email'],
          password: '', // Leave blank since it's not returned from API
        );
      } else {
        throw Exception("Failed to fetch user: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("User Fetch Error: ${e.toString()}");
    }
  }
}
