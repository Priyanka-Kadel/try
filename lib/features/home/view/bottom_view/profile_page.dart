import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/app/di/di.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:gear_rental/features/auth/presentation/view/login_page.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import the sensors package

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<AuthEntity> _userFuture;
  final AuthRemoteDataSource authDataSource = AuthRemoteDataSource(Dio());

  // Variable to hold dark mode state
  bool _isDarkMode = false;

  // Variables for shake detection
  double x = 0.0, y = 0.0, z = 0.0;
  double previousX = 0.0, previousY = 0.0, previousZ = 0.0;
  static const double shakeThreshold = 10;

  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   _userFuture = authDataSource.getCurrentUser(); // Fetch user data

  //   // Listen to the accelerometer data for shake detection
  //   _accelerometerSubscription =
  //       accelerometerEvents.listen((AccelerometerEvent event) {
  //     x = event.x;
  //     y = event.y;
  //     z = event.z;

  //     // Calculate change in acceleration
  //     double deltaX = x - previousX;
  //     double deltaY = y - previousY;
  //     double deltaZ = z - previousZ;

  //     // Calculate total movement
  //     double totalMovement =
  //         (deltaX * deltaX) + (deltaY * deltaY) + (deltaZ * deltaZ);

  //     // If total movement exceeds the threshold, trigger logout
  //     if (totalMovement > shakeThreshold) {
  //       _logoutUser();
  //     }

  //     // Update previous values
  //     previousX = x;
  //     previousY = y;
  //     previousZ = z;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _userFuture = authDataSource.getCurrentUser(); // Fetch user data

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration =
          (event.x * event.x) + (event.y * event.y) + (event.z * event.z);
      double prevAcceleration = (previousX * previousX) +
          (previousY * previousY) +
          (previousZ * previousZ);

      // Compute the difference in acceleration
      double deltaAcceleration = (acceleration - prevAcceleration).abs();

      // Use a higher threshold to detect any type of shake
      if (deltaAcceleration > shakeThreshold) {
        _logoutUser();
      }

      // Update previous values
      previousX = event.x;
      previousY = event.y;
      previousZ = event.z;
    });
  }

  // Function to handle user logout
  void _logoutUser() async {
    // Clear the user's session (e.g., using SharedPreferences)
    // This should include clearing authentication data or session tokens
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
          child: const LoginPage(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the accelerometer listener properly
    _accelerometerSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.green[50],
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color: _isDarkMode
                ? Colors.white
                : Colors.black, // Adjust text color based on dark mode
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Dark Mode Toggle Button
          Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            activeColor: Colors.yellow[700],
          ),
        ],
      ),
      body: FutureBuilder<AuthEntity>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No User Data",
                  style: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
            );
          }

          AuthEntity user = snapshot.data!;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.green[700],
                    backgroundImage:
                        user.image != null && user.image!.isNotEmpty
                            ? NetworkImage(user.image!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.username,
                    style: GoogleFonts.poppins(
                      color: _isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 9, 9, 9),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.email,
                    style: GoogleFonts.poppins(
                      color: _isDarkMode
                          ? Colors.white70
                          : const Color.fromARGB(179, 2, 2, 2),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 30),
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
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
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
