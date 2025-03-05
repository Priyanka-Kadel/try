import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/app/di/di.dart';
import 'package:gear_rental/features/auth/presentation/view/login_page.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      imagePath: 'assets/images/logo.png',
      title: 'Welcome to GoGear',
      description: 'Find and rent camping and trekking gear effortlessly.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/logo.png',
      title: 'Explore Gear Categories',
      description: 'Discover a wide range of gear for your next adventure.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/logo.png',
      title: 'Start Your Adventure with GoGear',
      description: 'Start Exploring Now!',
    ),
  ];

  void _navigateToLogin() {
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

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Stack(
        children: [
          // PageView for swiping between onboarding screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _pages,
          ),

          // Skip button (Bottom-left for first 2 screens, hidden on last)
          if (_currentPage < 2)
            Positioned(
              bottom: 40,
              left: 20,
              child: ElevatedButton(
                onPressed: _navigateToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8CD00), // Button color
                  foregroundColor: Colors.white, // White text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(140, 50), // Increased button size
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          // Next button (Bottom-right for first 2 screens)
          if (_currentPage < 2)
            Positioned(
              bottom: 40,
              right: 20,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8CD00), // Button color
                  foregroundColor: Colors.white, // White text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(140, 50), // Increased button size
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          // Page indicator dots at the bottom
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => buildDot(index),
              ),
            ),
          ),

          // Start Button (Only on last screen)
          if (_currentPage == 2)
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: ElevatedButton(
                onPressed: _navigateToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8CD00), // Button color
                  foregroundColor: Colors.white, // White text color
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(200, 60), // Increased button size
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Builds the dot for the indicator
  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFFA8CD00) : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Black text color
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54, // Black text color with opacity
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
