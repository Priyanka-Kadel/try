// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gear_rental/app/di/di.dart';
// import 'package:gear_rental/features/auth/presentation/view/signup_page.dart';
// import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';

// import '../view_model/login/login_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Colors.white, // Set background color to white for a cleaner look
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16.0), // Adjusted for symmetry
//           child: BlocBuilder<LoginBloc, LoginState>(
//             builder: (context, state) {
//               return Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Logo Section
//                     Center(
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         height: 120,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 40),

//                     // Title
//                     const Text(
//                       'Login To Your Account',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2E3A59), // Darker color for the title
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Username Field
//                     _buildTextField(
//                       controller: _usernameController,
//                       label: 'Email Address',
//                       icon: Icons.email,
//                       validator: (value) =>
//                           value!.isEmpty ? 'Email cannot be empty' : null,
//                     ),
//                     const SizedBox(height: 16),

//                     // Password Field with Toggle
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: const TextStyle(color: Color(0xFF2E3A59)),
//                         border: const OutlineInputBorder(),
//                         prefixIcon:
//                             const Icon(Icons.lock, color: Color(0xFF2E3A59)),
//                         filled: true,
//                         fillColor:
//                             Colors.grey[200], // Lighter fill for the background
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: const Color(0xFF2E3A59),
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                       style: const TextStyle(color: Color(0xFF2E3A59)),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Password cannot be empty' : null,
//                     ),
//                     const SizedBox(height: 24),

//                     // Login Button
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           context.read<LoginBloc>().add(
//                                 LoginUserEvent(
//                                   context: context,
//                                   username: _usernameController.text,
//                                   password: _passwordController.text,
//                                 ),
//                               );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(double.infinity, 50),
//                         backgroundColor:
//                             const Color(0xFFA8CD00), // Gogear theme yellow
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                     // Signup Navigation
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Do not have an account? ",
//                           style:
//                               TextStyle(color: Color(0xFF2E3A59), fontSize: 16),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return BlocProvider<RegisterBloc>(
//                                       create: (_) => getIt<RegisterBloc>(),
//                                       child: const SignupPage());
//                                 },
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'Sign up',
//                             style: TextStyle(
//                               color: Color(0xFFA8CD00), // Gogear yellow
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // Reusable TextFormField Widget
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(
//             color: Color(0xFF2E3A59)), // Gogear theme dark color
//         border: const OutlineInputBorder(),
//         prefixIcon:
//             Icon(icon, color: const Color(0xFF2E3A59)), // Matching color theme
//         filled: true,
//         fillColor: Colors.grey[200], // Slightly lighter background color
//       ),
//       style:
//           const TextStyle(color: Color(0xFF2E3A59)), // Gogear dark text color
//       validator: validator,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/app/di/di.dart';
import 'package:gear_rental/features/auth/presentation/view/signup_page.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';

import '../view_model/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with increased opacity
          Positioned.fill(
            child: Opacity(
              opacity:
                  0.5, // Adjusted opacity of the background image for better visibility
              child: Image.asset(
                'assets/images/login pic.png', // Your image file name
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
          ),
          // A stronger semi-transparent overlay to make the form stand out
          Container(
            color: Colors.black
                .withOpacity(0.7), // Increased opacity for the overlay
          ),
          // The Login Form on top of the background
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo Section
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png', // Replace with your logo
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Title
                        const Text(
                          'Login To Your Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .white, // Made the title white for contrast
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Username Field
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Email Address',
                          icon: Icons.email,
                          validator: (value) =>
                              value!.isEmpty ? 'Email cannot be empty' : null,
                        ),
                        const SizedBox(height: 16),

                        // Password Field with Toggle
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color:
                                    Colors.white), // White text for visibility
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.white), // White icon
                            filled: true,
                            fillColor: Colors.grey[
                                800], // Darker background for better contrast
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors
                                    .white, // White icon for better visibility
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.white), // White text
                          validator: (value) => value!.isEmpty
                              ? 'Password cannot be empty'
                              : null,
                        ),
                        const SizedBox(height: 24),

                        // Login Button
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginUserEvent(
                                      context: context,
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: const Color(0xFFA8CD00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Signup Navigation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do not have an account? ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider<RegisterBloc>(
                                          create: (_) => getIt<RegisterBloc>(),
                                          child: const SignupPage());
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color(
                                      0xFFA8CD00), // Green color for the signup link
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextFormField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: Colors.white), // White label for readability
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.white), // White icon for contrast
        filled: true,
        fillColor: Colors.grey[800], // Dark background for fields
      ),
      style: const TextStyle(
          color: Colors.white), // White text for better readability
      validator: validator,
    );
  }
}
