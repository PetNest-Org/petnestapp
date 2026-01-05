import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onCartTap;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    required this.userName,
    this.onCartTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// 🔹 LEFT SIDE (Logo + PetNest + Hello)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Logo + PetNest (same row)
                Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.pets,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "PetNest",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Hello text
                Text(
                  "Hello, $userName",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            /// 🔹 RIGHT SIDE (Icons)
            Row(
              children: [
                _iconButton(
                  icon: Icons.shopping_cart_outlined,
                  onTap: onCartTap,
                ),
                const SizedBox(width: 12),
                _iconButton(
                  icon: Icons.person_outline,
                  onTap: onProfileTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }
}
