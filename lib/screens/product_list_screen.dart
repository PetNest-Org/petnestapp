import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final double rating;
  final bool inStock;
  final String imagePath;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.inStock,
    required this.imagePath,
  });
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // ✅ Mock data (imagePath added)
  final List<Product> _all = const [
    Product(
      id: "p1",
      title: "Cotton T-Shirt",
      category: "Clothing",
      price: 399,
      rating: 4.3,
      inStock: true,
      imagePath: "assets/images/T-shartjpeg.jpeg",
    ),
    Product(
      id: "p2",
      title: "Running Shoes",
      category: "Footwear",
      price: 1999,
      rating: 4.6,
      inStock: true,
      imagePath: "assets/images/Shoes.jpeg",
    ),
    Product(
      id: "p3",
      title: "Bluetooth Headphones",
      category: "Electronics",
      price: 1499,
      rating: 4.2,
      inStock: true,
      imagePath: "assets/images/Bluetooth.jpeg",
    ),
    Product(
      id: "p4",
      title: "Smart Watch",
      category: "Electronics",
      price: 2999,
      rating: 4.4,
      inStock: false,
      imagePath: "assets/images/Smartwatch.jpeg",
    ),
    Product(
      id: "p5",
      title: "Denim Jeans",
      category: "Clothing",
      price: 1199,
      rating: 4.1,
      inStock: true,
      imagePath: "assets/images/jeans.jpeg",
    ),
    Product(
      id: "p6",
      title: "Sandals",
      category: "Footwear",
      price: 799,
      rating: 4.0,
      inStock: true,
      imagePath: "assets/images/sandal.jpeg",
    ),
    Product(
      id: "p7",
      title: "Laptop Backpack",
      category: "Accessories",
      price: 999,
      rating: 4.5,
      inStock: true,
      imagePath: "assets/images/backpack.jpeg",
    ),
    Product(
      id: "p8",
      title: "Sunglasses",
      category: "Accessories",
      price: 699,
      rating: 3.9,
      inStock: true,
     imagePath: "assets/images/sunglasses.jpeg",
    ),
  ];

  // Filters
  String _selectedCategory = "All";
  bool _onlyInStock = false;
  RangeValues _priceRange = const RangeValues(0, 5000);

  // Cart
  final Map<String, int> _cartQty = {}; // productId -> qty
  int get _cartCount => _cartQty.values.fold(0, (sum, q) => sum + q);

  List<String> get _categories {
    final cats = _all.map((p) => p.category).toSet().toList()..sort();
    return ["All", ...cats];
  }

  List<Product> get _filtered {
    return _all.where((p) {
      final categoryOk = (_selectedCategory == "All") || (p.category == _selectedCategory);
      final stockOk = !_onlyInStock || p.inStock;
      final priceOk = p.price >= _priceRange.start && p.price <= _priceRange.end;
      return categoryOk && stockOk && priceOk;
    }).toList();
  }

  void _addToCart(Product p) {
    if (!p.inStock) return;
    setState(() {
      _cartQty[p.id] = (_cartQty[p.id] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${p.title} added to cart"),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        String tempCat = _selectedCategory;
        bool tempStock = _onlyInStock;
        RangeValues tempRange = _priceRange;

        return StatefulBuilder(
          builder: (ctx, setModal) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 16),

                    const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _categories.map((c) {
                        final selected = tempCat == c;
                        return ChoiceChip(
                          label: Text(c),
                          selected: selected,
                          onSelected: (_) => setModal(() => tempCat = c),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Only In Stock"),
                      value: tempStock,
                      onChanged: (v) => setModal(() => tempStock = v),
                    ),

                    const SizedBox(height: 8),

                    const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w600)),
                    RangeSlider(
                      values: tempRange,
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      labels: RangeLabels(
                        "₹${tempRange.start.round()}",
                        "₹${tempRange.end.round()}",
                      ),
                      onChanged: (v) => setModal(() => tempRange = v),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = "All";
                                _onlyInStock = false;
                                _priceRange = const RangeValues(0, 5000);
                              });
                              Navigator.pop(ctx);
                            },
                            child: const Text("Reset"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedCategory = tempCat;
                                _onlyInStock = tempStock;
                                _priceRange = tempRange;
                              });
                              Navigator.pop(ctx);
                            },
                            child: const Text("Apply"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            tooltip: "Filters",
            onPressed: _openFilters,
            icon: const Icon(Icons.tune),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Cart items: $_cartCount")),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
                if (_cartCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _cartCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Showing ${items.length} items • Category: $_selectedCategory • "
                    "${_onlyInStock ? "In stock" : "All"} • ₹${_priceRange.start.round()}-₹${_priceRange.end.round()}",
                    style: TextStyle(color: Colors.grey.shade700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton.icon(
                  onPressed: _openFilters,
                  icon: const Icon(Icons.filter_alt_outlined),
                  label: const Text("Filters"),
                )
              ],
            ),
          ),

          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("No products found for these filters."))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.60, // ✅ more height, overflow कमी
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _ProductCard(
                      product: items[i],
                      onAdd: () => _addToCart(items[i]),
                      qtyInCart: _cartQty[items[i].id] ?? 0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final int qtyInCart;

  const _ProductCard({
    required this.product,
    required this.onAdd,
    required this.qtyInCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: SingleChildScrollView( // ✅ overflow full fix
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 38,
                        color: Colors.grey.shade500,
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                child: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "₹${product.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                    _RatingPill(rating: product.rating),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 8),
                child: Text(
                  product.inStock ? "In Stock" : "Out of Stock",
                  style: TextStyle(
                    fontSize: 12,
                    color: product.inStock ? Colors.green.shade700 : Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: FilledButton.icon(
                    onPressed: product.inStock ? onAdd : null,
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: Text(qtyInCart > 0 ? "Add (x$qtyInCart)" : "Add to Cart"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final double rating;
  const _RatingPill({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.black.withOpacity(0.06),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 14),
          const SizedBox(width: 4),
          Text(rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
