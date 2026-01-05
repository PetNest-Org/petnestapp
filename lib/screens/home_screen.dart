import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/common/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(userName: "Rachit"),
              const SizedBox(height: 16),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Search 'dog food' or 'grooming'...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Auto-changing promo banner (carousel)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _PromoCarousel(),
              ),

              const SizedBox(height: 20),

              // Services title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Services near you",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "SEE ALL",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Services horizontal (order as screenshot)
              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    _ServiceCard(
                      icon: Icons.shield_outlined,
                      title: "Home Vet Visit",
                      duration: "60 min",
                      price: "Book ₹2499",
                    ),
                    SizedBox(width: 14),
                    _ServiceCard(
                      icon: Icons.content_cut,
                      title: "Full Grooming",
                      duration: "90 min",
                      price: "Book ₹1499",
                    ),
                    SizedBox(width: 14),
                    _ServiceCard(
                      icon: Icons.person_outline,
                      title: "Dog Walking",
                      duration: "30 min",
                      price: "Book ₹199",
                    ),
                    SizedBox(width: 14),

                    // ✅ UPDATED ICON HERE: filled -> outlined
                    _ServiceCard(
                      icon: Icons.pets_outlined, // 👈 2nd image सारखा outline paw
                      title: "Pet Sitting",
                      duration: "1 Day",
                      price: "Book ₹999",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Bestsellers",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Bestsellers grid (4 cards only)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: 370,
                  ),
                  itemBuilder: (context, index) {
                    const items = [
                      _BestsellerCard(
                        bgColor: Color(0xFFFFF7E6),
                        label: "Pet Food",
                        labelColor: Color(0xFFD97706),
                        weight: "3kg",
                        title: "Royal Canin Adult Dry Dog Food",
                        rating: "4.8",
                        reviews: "(5,210)",
                        time: "12 mins",
                        off: "7% OFF",
                        price: "₹2800",
                        oldPrice: "₹3000",
                        unitPrice: "₹93.33/kg",
                      ),
                      _BestsellerCard(
                        bgColor: Color(0xFFEFF6FF),
                        label: "Pet Food",
                        labelColor: Color(0xFF2563EB),
                        tag: "Trending",
                        weight: "1.2kg",
                        title: "Pedigree Pro Puppy Food",
                        rating: "4.7",
                        reviews: "(11,432)",
                        time: "12 mins",
                        off: "7% OFF",
                        price: "₹650",
                        oldPrice: "₹700",
                        unitPrice: "₹54.16/100g",
                      ),
                      _BestsellerCard(
                        bgColor: Color(0xFFF3E8FF),
                        label: "Cat Food",
                        labelColor: Color(0xFF7C3AED),
                        weight: "85g",
                        title: "Sheba Cat Food - Tuna in Jelly",
                        rating: "4.9",
                        reviews: "(8,991)",
                        time: "15 mins",
                        price: "₹55",
                        unitPrice: "₹6.47/10g",
                        optionsText: "2 options",
                      ),
                      _BestsellerCard(
                        bgColor: Color(0xFFEFFCF2),
                        label: "Pet Food",
                        labelColor: Color(0xFF166534),
                        weight: "3kg",
                        title: "Himalaya Healthy Pet Food",
                        rating: "4.6",
                        reviews: "(3,104)",
                        time: "18 mins",
                        off: "4% OFF",
                        price: "₹1200",
                        oldPrice: "₹1250",
                        unitPrice: "₹40.00/100g",
                      ),
                    ];
                    return items[index];
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                PROMO CAROUSEL                              */
/* -------------------------------------------------------------------------- */

class _PromoCarousel extends StatefulWidget {
  const _PromoCarousel();

  @override
  State<_PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<_PromoCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _index = 0;

  final List<_PromoItem> _items = const [
    _PromoItem(
      bg: Color(0xFFE9F7F7),
      text: "Grooming\nSpecials",
      textColor: Color(0xFF2AA39A),
    ),
    _PromoItem(
      bg: Color(0xFFFFF8E6),
      text: "Free Vet\nConsultation",
      textColor: Color(0xFFE0A400),
    ),
    _PromoItem(
      bg: Color(0xFFE6F5FF),
      text: "50% OFF\nPet Food",
      textColor: Color(0xFF087EA3),
    ),
    _PromoItem(
      bg: Color(0xFFF1E9FF),
      text: "New Toys\nCollection",
      textColor: Color(0xFF7C3AED),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _index = (_index + 1) % _items.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: PageView.builder(
          controller: _controller,
          itemCount: _items.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) {
            final item = _items[i];
            return Container(
              color: item.bg,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                item.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  color: item.textColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PromoItem {
  final Color bg;
  final String text;
  final Color textColor;

  const _PromoItem({
    required this.bg,
    required this.text,
    required this.textColor,
  });
}

/* -------------------------------------------------------------------------- */
/*                                 SERVICE CARD                               */
/* -------------------------------------------------------------------------- */

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String duration;
  final String price;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFEFF6FF),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(duration, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6CF6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               BESTSELLER CARD                              */
/* -------------------------------------------------------------------------- */

class _BestsellerCard extends StatefulWidget {
  final Color bgColor;
  final String label;
  final Color labelColor;

  final String weight;
  final String title;
  final String rating;
  final String reviews;
  final String time;

  final String price;
  final String? oldPrice;
  final String? unitPrice;

  final String? off;
  final String? tag;
  final String? optionsText;

  const _BestsellerCard({
    required this.bgColor,
    required this.label,
    required this.labelColor,
    required this.weight,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.time,
    required this.price,
    this.oldPrice,
    this.unitPrice,
    this.off,
    this.tag,
    this.optionsText,
  });

  @override
  State<_BestsellerCard> createState() => _BestsellerCardState();
}

class _BestsellerCardState extends State<_BestsellerCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top image block + heart + tag
          Stack(
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: widget.labelColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: InkWell(
                  onTap: () => setState(() => isLiked = !isLiked),
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEAEAEA)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              if (widget.tag != null)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8CC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.tag!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),

          // Weight row (green square + text)
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.weight,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            widget.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 6),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                widget.rating,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 6),
              Text(widget.reviews, style: const TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 6),

          // Time
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey, size: 18),
              const SizedBox(width: 6),
              Text(widget.time, style: const TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 10),

          // OFF label
          if (widget.off != null)
            Text(
              widget.off!,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),

          const Spacer(),

          // ✅ PRICE (kept same as your latest: smaller + fitted)
          LayoutBuilder(
            builder: (context, c) {
              final bool small = c.maxWidth < 170;

              final double priceFont = small ? 17 : 19;
              final double unitFont = small ? 12 : 13;

              final bool showOld = (widget.oldPrice != null) && !small;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.price,
                                  style: TextStyle(
                                    fontSize: priceFont,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (showOld)
                              Flexible(
                                child: Text(
                                  widget.oldPrice!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (widget.unitPrice != null)
                          Text(
                            widget.unitPrice!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w700,
                              fontSize: unitFont,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: small ? 86 : 104,
                    height: 44,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: Center(
                        child: widget.optionsText == null
                            ? const Text(
                                "ADD",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.green,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "ADD",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    widget.optionsText!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
