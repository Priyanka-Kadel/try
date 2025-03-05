import 'package:flutter/material.dart';
import 'package:gear_rental/features/home/view/bottom_view/all_gears_page.dart';
import 'package:gear_rental/features/home/view/bottom_view/cart.dart';
import 'package:gear_rental/features/home/view/bottom_view/profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  // List of pages to display for each bottom navigation item
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
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 43, 0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'GoGear',
          style: TextStyle(
              color: Color.fromARGB(255, 247, 246, 244), fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex], // Display the selected page
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
                icon: Icons.explore,
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

// Pages for Each Bottom Navigation Item //

class DashboardHomePage extends StatelessWidget {
  DashboardHomePage({super.key});

  // Sample list of products from the provided data
  final List<Product> products = [
    Product(
      name: 'Trekking Bag',
      description: 'Very comfortable',
      price: 300.0,
      status: 'Available',
      image: 'assets/images/backpack.png', // Update with the correct image path
    ),
    Product(
      name: 'Green Tent',
      description: 'Fits 6 people, Insulation',
      price: 500.0,
      status: 'Available',
      image: 'assets/images/tent.png', // Update with the correct image path
    ),
    Product(
      name: 'Blue Tent',
      description: 'Fits 4 people, Insulation',
      price: 300.0,
      status: 'Available',
      image: 'assets/images/tent blue.png',
      // Update with the correct image path
    ),
    Product(
      name: 'Camping Gas',
      description: 'Very comfortable',
      price: 150.0,
      status: 'Available',
      image: 'assets/images/gas.png', // Update with the correct image path
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      spreadRadius: 2)
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Products',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Trending Section
            const Text(
              'Trending',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Swipable Product Cards (Trending)
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: (products.length / 2)
                    .ceil(), // Calculate pages to display two cards
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Show product detail as a popup dialog
                            showDialog(
                              context: context,
                              builder: (context) => ProductDetailDialog(
                                  product: products[firstIndex]),
                            );
                          },
                          child: HotDealCard(
                            imagePath: products[firstIndex].image,
                            category: 'Camping Gear',
                            name: products[firstIndex].name,
                            price: 'NPR ${products[firstIndex].price}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (secondIndex < products.length)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Show product detail as a popup dialog
                              showDialog(
                                context: context,
                                builder: (context) => ProductDetailDialog(
                                    product: products[secondIndex]),
                              );
                            },
                            child: HotDealCard(
                              imagePath: products[secondIndex].image,
                              category: 'Camping Gear',
                              name: products[secondIndex].name,
                              price: 'NPR ${products[secondIndex].price}',
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Least Expensive Section
            const Text(
              'Least Expensive',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Swipable Product Cards (Least Expensive)
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: (products.length / 2)
                    .ceil(), // Calculate pages to display two cards
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Show product detail as a popup dialog
                            showDialog(
                              context: context,
                              builder: (context) => ProductDetailDialog(
                                  product: products[firstIndex]),
                            );
                          },
                          child: HotDealCard(
                            imagePath: products[firstIndex].image,
                            category: 'Camping Gear',
                            name: products[firstIndex].name,
                            price: 'NPR ${products[firstIndex].price}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (secondIndex < products.length)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Show product detail as a popup dialog
                              showDialog(
                                context: context,
                                builder: (context) => ProductDetailDialog(
                                    product: products[secondIndex]),
                              );
                            },
                            child: HotDealCard(
                              imagePath: products[secondIndex].image,
                              category: 'Camping Gear',
                              name: products[secondIndex].name,
                              price: 'NPR ${products[secondIndex].price}',
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Model
class Product {
  final String name;
  final String description;
  final double price;
  final String status;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    required this.image,
  });
}

// Hot Deal Card Widget //

class HotDealCard extends StatelessWidget {
  final String imagePath;
  final String category;
  final String name;
  final String price;

  const HotDealCard({
    super.key,
    required this.imagePath,
    required this.category,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 90, // Adjusted width for side by side cards
              height: 130, // Taller height
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              category,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Dialog
class ProductDetailDialog extends StatelessWidget {
  final Product product;

  const ProductDetailDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(product.image,
                width: 200, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text(product.description,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),
            Text(
              'NPR ${product.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
                // Show the cart added notification
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
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
  }
}

// Bottom Navigation Item Widget //

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28,
        color:
            isSelected ? const Color.fromARGB(255, 136, 245, 96) : Colors.white,
      ),
    );
  }
}
