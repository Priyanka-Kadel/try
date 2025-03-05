// import 'dart:io';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tech_rental/app/di/di.dart';
// import 'package:tech_rental/core/common/snackbar/my_snackbar.dart';
// import 'package:tech_rental/features/auth/domain/use_case/upload_image_usecase.dart';
// import 'package:tech_rental/features/auth/presentation/view/login_page.dart';
// import 'package:tech_rental/features/auth/presentation/view_model/login/login_bloc.dart';

// import '../../../domain/use_case/register_user_usecase.dart';

// part 'register_event.dart';
// part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final RegisterUseCase _registerUseCase;
//   final UploadImageUsecase _uploadImageUsecase;

//   RegisterBloc({
//     required RegisterUseCase registerUseCase,
//     required UploadImageUsecase uploadImageUsecase,
//   })  : _registerUseCase = registerUseCase,
//         _uploadImageUsecase = uploadImageUsecase,
//         super(RegisterState.initial()) {
//     on<Registercustomer>(_onRegisterEvent);
//     on<UploadImage>(_onLoadImage);
//   }

//   void _onRegisterEvent(
//     Registercustomer event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _registerUseCase.call(RegisterUserParams(
//       username: event.username,
//       password: event.password,
//       email: event.email,
//       image: state.imageName,
//     ));

//     result.fold(
//       (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//       (r) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//             context: event.context, message: "Registration Successful");

//         // Redirect to login after 2 seconds
//         Future.delayed(const Duration(seconds: 2), () {
//           Navigator.pushReplacement(
//             event.context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider<LoginBloc>(
//                 create: (_) => getIt<LoginBloc>(),
//                 child: const LoginPage(),
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   void _onLoadImage(
//     UploadImage event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _uploadImageUsecase.call(
//       UploadImageParams(
//         file: event.image,
//       ),
//     );

//     result.fold(
//       (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//       (r) {
//         emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/app/di/di.dart';
import 'package:gear_rental/core/common/snackbar/my_snackbar.dart';
import 'package:gear_rental/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:gear_rental/features/auth/presentation/view/login_page.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';

import '../../../domain/use_case/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {
    on<RegisterCustomer>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);
  }

  // 📌 Registration Event Handler
  void _onRegisterEvent(
    RegisterCustomer event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _registerUseCase.call(RegisterUserParams(
      username: event.username,
      password: event.password,
      email: event.email,
      image: state.imageName,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));

        // ✅ Fix Snackbar Issue
        if (event.context.mounted) {
          showMySnackBar(
              context: event.context, message: "Registration Successful");
        }

        // ✅ Fix Navigation Issue
        Future.delayed(const Duration(seconds: 2), () {
          if (event.context.mounted) {
            Navigator.of(event.context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BlocProvider<LoginBloc>(
                  create: (_) => getIt<LoginBloc>(),
                  child: const LoginPage(),
                ),
              ),
            );
          }
        });
      },
    );
  }

  // 📌 Image Upload Event Handler
  void _onLoadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.image,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
