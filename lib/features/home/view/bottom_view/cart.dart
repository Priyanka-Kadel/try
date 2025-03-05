import 'package:flutter/material.dart';

// Cart Page Widget
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart items
  List<CartItemData> cartItems = [
    CartItemData(
      name: 'Trekking Bag',
      description: 'Very comfortable',
      price: 300.0,
      imagePath: 'assets/images/backpack.png',
    ),
    CartItemData(
      name: 'Green Tent',
      description: 'Fits 6 people, Insulation',
      price: 500.0,
      imagePath: 'assets/images/tent.png',
    ),
    CartItemData(
      name: 'Camping Gas',
      description: 'Very comfortable',
      price: 150.0,
      imagePath: 'assets/images/gas.png',
    ),
  ];

  // Remove item from cart
  void _removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Proceed to payment
  void _proceedToPayment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proceeding to Payment...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color.fromARGB(255, 6, 43, 0),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartItem(
                  cartItem: cartItem,
                  onRemove: () => _removeFromCart(index),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _proceedToPayment,
          child: const Text(
            'Proceed to Payment',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// Cart Item Model (for each item in the cart)
class CartItemData {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  CartItemData({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

// Cart Item Widget
class CartItem extends StatelessWidget {
  final CartItemData cartItem;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.asset(
          cartItem.imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          cartItem.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          cartItem.description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Price Text with "per day"
            Text(
              'NPR ${cartItem.price} /per day',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            // Cross Icon to remove item
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
