// part of 'register_bloc.dart';

// sealed class RegisterEvent extends Equatable {
//   const RegisterEvent();

//   @override
//   List<Object> get props => [];
// }

// class UploadImage extends RegisterEvent {
//   final BuildContext context;
//   final File image;

//   const UploadImage({
//     required this.context,
//     required this.image,
//   });
// }

// class Registercustomer extends RegisterEvent {
//   final BuildContext context;
//   final String email;
//   final String username;
//   final String password;
//   final File? image;

//   const Registercustomer({
//     required this.context,
//     required this.email,
//     required this.username,
//     required this.password,
//     this.image,
//   });
// }

// class NavigateToLogin extends RegisterEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateToLogin({
//     required this.context,
//     required this.destination,
//   });
// }

part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 📌 Register Customer Event
class RegisterCustomer extends RegisterEvent {
  final String username;
  final String password;
  final String email;
  final BuildContext context;

  RegisterCustomer({
    required this.username,
    required this.password,
    required this.email,
    required this.context, // ✅ Fix: Pass BuildContext
  });

  @override
  List<Object?> get props => [username, password, email, context];
}

// 📌 Upload Image Event
class UploadImage extends RegisterEvent {
  final File image;

  UploadImage({required this.image});

  @override
  List<Object?> get props => [image];
}
