import 'package:demopetnest/VetBooking.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: "Pedigree Dog Food",
      weight: "5 kg",
      price: 1200,
      quantity: 1,
    ),
    CartItem(
      name: "Chew Toy",
      weight: "Medium",
      price: 399,
      quantity: 2,
    ),
  ];

  final Color primaryColor = const Color(0xFF0860B9);
  final Color accentColor = const Color(0xFF795548);

  double deliveryFee = 50;

  double get itemTotal =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get grandTotal => itemTotal + deliveryFee;

  int get petCoins => (itemTotal / 100).floor() * 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return cartItemCard(cartItems[index]);
              },
            ),
          ),
          billSummary(),
        ],
      ),
    );
  }

  Widget cartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/images/dog-food.jpg',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.weight,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${item.price}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                quantityButton(
                  icon: Icons.add,
                  onTap: () {
                    setState(() {
                      item.quantity++;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    item.quantity.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                quantityButton(
                  icon: Icons.remove,
                  onTap: () {
                    setState(() {
                      if (item.quantity > 1) item.quantity--;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget quantityButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: primaryColor),
      ),
    );
  }

  Widget billSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.85),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          billRow("Item Total", "₹${itemTotal.toStringAsFixed(0)}"),
          billRow("Delivery Fee", "₹${deliveryFee.toStringAsFixed(0)}"),
          const Divider(color: Colors.white54),
          billRow(
            "Grand Total",
            "₹${grandTotal.toStringAsFixed(0)}",
            isBold: true,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "🎁 You will earn $petCoins PetCoins",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VetBookingScreen(),));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Proceed to Checkout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget billRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final String weight;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.weight,
    required this.price,
    required this.quantity,
  });
}
