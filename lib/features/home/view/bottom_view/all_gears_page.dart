import 'dart:async'; // For inactivity timer

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import sensors_plus package

class AllGearsPage extends StatefulWidget {
  const AllGearsPage({super.key});

  @override
  State<AllGearsPage> createState() => _AllGearsPageState();
}

class _AllGearsPageState extends State<AllGearsPage> {
  late Future<List<dynamic>> _gearsFuture;
  final AuthRemoteDataSource authDataSource = AuthRemoteDataSource(Dio());

  Timer? _inactiveTimer; // Timer for inactivity
  bool _isInactive = false; // Flag to track inactivity
  bool _isMoving = false; // Flag to track device movement (using Gyroscope)

  @override
  void initState() {
    super.initState();
    _gearsFuture = authDataSource.getProducts();

    // Initialize gyroscope and listener for activity detection
    _startGyroscopeListener();

    // Start inactivity timer when the page is loaded
    _resetInactivityTimer();
  }

  @override
  void dispose() {
    _inactiveTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Method to start gyroscope listener
  void _startGyroscopeListener() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Check if there is significant rotation on any axis (x, y, or z)
      if (event.x.abs() > 1.0 || event.y.abs() > 1.0 || event.z.abs() > 1.0) {
        // Device is moving/rotating, reset the inactivity timer
        if (!_isMoving) {
          setState(() {
            _isMoving = true;
          });
          _resetInactivityTimer();
        }
      } else {
        // Device is not moving/rotating
        if (_isMoving) {
          setState(() {
            _isMoving = false;
          });
        }
      }
    });
  }

  // Method to reset the inactivity timer
  void _resetInactivityTimer() {
    // Cancel any existing timers
    _inactiveTimer?.cancel();

    // Start a new timer
    _inactiveTimer = Timer(const Duration(seconds: 10), _showInactivityAlert);
  }

  // Method to show an inactivity alert
  void _showInactivityAlert() {
    if (!_isInactive) {
      setState(() {
        _isInactive = true;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Inactive User'),
            content:
                const Text('You have been inactive for more than 10 seconds!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isInactive = false;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width using MediaQuery for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine grid layout based on screen width (Tablet vs Phone)
    int crossAxisCount =
        screenWidth > 600 ? 3 : 2; // 3 items per row for tablet, 2 for phone

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Explore All Gears",
            style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _gearsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Failed to load gears",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please try again later.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No gears available",
                  style: TextStyle(color: Colors.white)),
            );
          }

          List<dynamic> gears = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Adjusted based on screen size
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: gears.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    gears[index]['imageUrl'] = gears[index]['imageUrl']!
                        .replaceAll('localhost', '10.0.2.2');
                    // .replaceAll('localhost', '192.168.16.104');
                    _showGearDetails(context, gears[index]);
                  },
                  child: GearCard(
                    imagePath: gears[index]['imageUrl']!,
                    name: gears[index]['name']!,
                    price: gears[index]['price'].toString(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showGearDetails(BuildContext context, dynamic gear) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gear['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display product image
                Image.network(
                  gear['imageUrl']!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                // Display product description
                Text(
                  gear['description'] ?? 'No description available.',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Display product price
                Text(
                  'NPR ${gear['price']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // "Add to Cart" button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    backgroundColor: Colors.green[700], // Cart button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    // Show cart added notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${gear['name']} added to cart'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GearCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const GearCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imagePath.replaceAll('localhost', '10.0.2.2'),
              // imagePath.replaceAll('localhost', '192.168.16.104'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(price,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
