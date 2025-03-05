import 'package:flutter/material.dart';
import 'package:gear_rental/features/home/view/bottom_view/all_gears_page.dart';
import 'package:gear_rental/features/home/view/bottom_view/cart.dart';
import 'package:gear_rental/features/home/view/bottom_view/dashboard.dart';
import 'package:gear_rental/features/home/view/bottom_view/profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardHomePage(),
    const AllGearsPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(156, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 71, 4),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'GoGear',
          style: TextStyle(color: Colors.green[700], fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(12, 21, 54, 0.612),
          border: Border(
            top: BorderSide(color: Colors.grey.shade800, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavItem(
                icon: Icons.home,
                isSelected: _currentIndex == 0,
                onTap: () => _onTabTapped(0),
              ),
              BottomNavItem(
                icon: Icons.backpack,
                isSelected: _currentIndex == 1,
                onTap: () => _onTabTapped(1),
              ),
              BottomNavItem(
                icon: Icons.shopping_cart,
                isSelected: _currentIndex == 2,
                onTap: () => _onTabTapped(2),
              ),
              BottomNavItem(
                icon: Icons.person,
                isSelected: _currentIndex == 3,
                onTap: () => _onTabTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
