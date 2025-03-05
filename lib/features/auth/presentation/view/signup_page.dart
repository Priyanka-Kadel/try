// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gear_rental/app/di/di.dart';
// import 'package:gear_rental/features/auth/presentation/view/login_page.dart';
// import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   File? _image;
//   final picker = ImagePicker();

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void _showImagePicker() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(16),
//         height: 160,
//         child: Column(
//           children: [
//             const Text(
//               "Choose an option",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.camera);
//                   },
//                   icon: const Icon(Icons.camera),
//                   label: const Text("Camera"),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _pickImage(ImageSource.gallery);
//                   },
//                   icon: const Icon(Icons.photo_library),
//                   label: const Text("Gallery"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(156, 25, 44, 113),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Image Picker Field
//                 GestureDetector(
//                   onTap: _showImagePicker,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.white.withOpacity(0.1),
//                     backgroundImage: _image != null ? FileImage(_image!) : null,
//                     child: _image == null
//                         ? const Icon(Icons.camera_alt,
//                             size: 40, color: Colors.white70)
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Tap to upload a profile picture",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 30),

//                 const Text(
//                   'BorrowBox Signup',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Username Field
//                 TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name',
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     border: const OutlineInputBorder(),
//                     prefixIcon: const Icon(Icons.person, color: Colors.white70),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.1),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Enter your username' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 // Email Field
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.email, color: Colors.white70),
//                     labelText: 'Email',
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     border: const OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.1),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Enter your email' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 // Password Field
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     border: const OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.1),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Enter your password' : null,
//                 ),
//                 const SizedBox(height: 16),

//                 // Confirm Password Field
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                     labelText: 'Confirm Password',
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     border: const OutlineInputBorder(),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.1),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Confirm your password';
//                     } else if (value != _passwordController.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 // Signup Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       context.read<RegisterBloc>().add(
//                             RegisterCustomer(
//                               context: context,
//                               email: _emailController.text,
//                               username: _usernameController.text,
//                               password: _passwordController.text,
//                               // image: _image, // Image can be null
//                             ),
//                           );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: const Color(0xFFF9B401),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 // Login Navigation
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already have an account?",
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlocProvider<LoginBloc>(
//                               create: (_) => getIt<LoginBloc>(),
//                               child: const LoginPage(),
//                             ),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'Sign In',
//                         style:
//                             TextStyle(color: Color(0xFFF9B401), fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/app/di/di.dart';
import 'package:gear_rental/features/auth/presentation/view/login_page.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: 160,
        child: Column(
          children: [
            const Text(
              "Choose an option",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with increased opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.5, // Adjusted opacity for the background image
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
          // The Signup Form on top of the background
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image Picker Field
                    GestureDetector(
                      onTap: _showImagePicker,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.camera_alt,
                                size: 40, color: Colors.white70)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tap to upload a profile picture",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Gogear Signup',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Username Field
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Full Name',
                      icon: Icons.person,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your username' : null,
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your email' : null,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your password' : null,
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    _buildTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Signup Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterBloc>().add(
                                RegisterCustomer(
                                  context: context,
                                  email: _emailController.text,
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                  // image: _image, // Image can be null
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor:
                            const Color(0xFFA8CD00), // Gogear yellow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Login Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider<LoginBloc>(
                                  create: (_) => getIt<LoginBloc>(),
                                  child: const LoginPage(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Color(0xFFA8CD00), fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextFormField Widget with dark background and white icons
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.white), // White icon
        filled: true,
        fillColor: Colors.grey[800], // Dark background for fields
      ),
      style: const TextStyle(color: Colors.white), // White text for contrast
      validator: validator,
    );
  }
}
