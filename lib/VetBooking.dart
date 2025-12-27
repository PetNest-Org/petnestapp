import 'package:demopetnest/BookAppointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VetBookingScreen extends StatefulWidget {
  const VetBookingScreen({super.key});

  @override
  State<VetBookingScreen> createState() => _VetBookingScreenState();
}

class _VetBookingScreenState extends State<VetBookingScreen> {
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    "All",
    "General Surgeon",
    "Dermatology",
    "Nutritionist",
    "Orthopedics",
    "Cardiology",
    "General Physician"
  ];

  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Amit Patel",
      speciality: "Dermatology",
      initials: "AP",
      rating: 4.7,
      experience: 12,
      distance: 3.5,
      clinicFee: 800,
      homeFee: 1300,
    ),
    Doctor(
      name: "Dr. Priya Sharma",
      speciality: "Nutritionist",
      initials: "PS",
      rating: 4.8,
      experience: 5,
      distance: 2.1,
      clinicFee: 600,
      homeFee: 900,
    ),
    Doctor(
      name: "Dr. Sarah Wilson",
      speciality: "General Surgeon",
      initials: "SW",
      rating: 4.9,
      experience: 8,
      distance: 1.2,
      clinicFee: 500,
      homeFee: 1000,
    ),
  ];

  String get headingText {
    return selectedCategoryIndex == 0
        ? "Available Doctors"
        : "${categories[selectedCategoryIndex]} Doctors";
  }

  List<Doctor> get filteredDoctors {
    if (selectedCategoryIndex == 0) return doctors;
    return doctors
        .where((d) => d.speciality == categories[selectedCategoryIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// TOP SECTION
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Consult a Specialist",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Find the right doctor for your pet's needs.",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    emergencyCard(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            /// 🔥 STICKY CATEGORY BAR
            SliverPersistentHeader(
              pinned: true,
              delegate: CategoryHeader(
                categories: categories,
                selectedIndex: selectedCategoryIndex,
                onChanged: (index) {
                  setState(() => selectedCategoryIndex = index);
                },
              ),
            ),

            /// HEADING
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  headingText,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// DOCTOR LIST
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return doctorCard(filteredDoctors[index]);
                  },
                  childCount: filteredDoctors.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- EMERGENCY CARD ----------------

  Widget emergencyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7A18), Color(0xFFFF3D3D)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Medical Emergency?",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Connect with a vet in 2 mins",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined),
                  label: const Text("SOS Call Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.timer, color: Colors.white, size: 36),
        ],
      ),
    );
  }

  // ---------------- DOCTOR CARD (UNCHANGED UI) ----------------

  Widget doctorCard(Doctor doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.purple.shade100,
                child: Text(
                  doctor.initials,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(doctor.speciality),
                    Text(
                        "${doctor.experience} years exp • ${doctor.distance}km"),
                  ],
                ),
              ),
              ratingBadge(doctor.rating),
            ],
          ),
          const SizedBox(height: 16),
          visitButtons(doctor),
        ],
      ),
    );
  }

  Widget ratingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(rating.toString(),
              style: GoogleFonts.inter(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget visitButtons(Doctor doctor) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookAppointmentScreen(
                    doctor: doctor,
                    visitType: "Clinic",
                  ),
                ),
              );
            },
            child: visitButton(
              "CLINIC VISIT",
              "₹${doctor.clinicFee}",
              false,
            ),
          ),
        ),

        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookAppointmentScreen(
                    doctor: doctor,
                    visitType: "Home",
                  ),
                ),
              );
            },
            child: visitButton(
              "HOME VISIT",
              "₹${doctor.homeFee}",
              true,
            ),
          ),
        ),

      ],
    );
  }

  Widget visitButton(String title, String price, bool filled) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFF0860B9) : const Color(0xFFF3F7FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: filled ? Colors.white : const Color(0xFF0860B9),
              )),
          const SizedBox(height: 4),
          Text(price,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: filled ? Colors.white : const Color(0xFF0860B9),
              )),
        ],
      ),
    );
  }
}

class Doctor {
  final String name;
  final String speciality;
  final String initials;
  final double rating;
  final int experience;
  final double distance;
  final int clinicFee;
  final int homeFee;

  Doctor({
    required this.name,
    required this.speciality,
    required this.initials,
    required this.rating,
    required this.experience,
    required this.distance,
    required this.clinicFee,
    required this.homeFee,
  });
}


class CategoryHeader extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onChanged;

  CategoryHeader({
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  double get minExtent => 64;
  @override
  double get maxExtent => 64;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color:
                isSelected ? const Color(0xFF0860B9) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                categories[index],
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CategoryHeader oldDelegate) => true;
}
