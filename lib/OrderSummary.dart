import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'PaymentScreen.dart';
import 'VetBooking.dart';

class OrderSummaryScreen extends StatelessWidget {
  final Doctor doctor;
  final String visitType; // "Clinic Visit" or "Home Visit"
  final String selectedDate;
  final String selectedTime;

  const OrderSummaryScreen({
    super.key,
    required this.doctor,
    required this.visitType,
    required this.selectedDate,
    required this.selectedTime,
  });

  static const int platformFee = 6;

  int get serviceAmount {
    final type = visitType.toLowerCase();

    if (type.contains("clinic")) {
      return doctor.clinicFee;
    } else {
      return doctor.homeFee;
    }
  }

  int get totalAmount => serviceAmount + platformFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Order Summary",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          stepsHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  serviceAddressCard(),
                  doctorSummaryCard(),
                  priceDetailsCard(),
                ],
              ),
            ),
          ),

          bottomBar(context),
        ],
      ),
    );
  }

  // ================= STEPS =================

  Widget stepsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          step("Address", true),
          step("Order Summary", true),
          step("Payment", false),
        ],
      ),
    );
  }

  Widget step(String title, bool done) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: done ? Colors.blue : Colors.grey.shade300,
          child: done
              ? const Icon(Icons.check, size: 18, color: Colors.white)
              : Text("3",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: done ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  // ================= ADDRESS =================

  Widget serviceAddressCard() {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Service Address",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Change",
                  style: GoogleFonts.inter(
                      color: Colors.blue, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Text("Rachit Kumar Padhan",
              style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            "Kendumundi Road, Northern Division\nDhanbad, Jharkhand - 703832",
            style: GoogleFonts.inter(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  // ================= DOCTOR =================

  Widget doctorSummaryCard() {
    return card(
      child: Row(
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
                Text(
                  "$visitType with ${doctor.name}",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "on $selectedDate at $selectedTime",
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "₹$serviceAmount",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ================= PRICE DETAILS =================

  Widget priceDetailsCard() {
    return card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price Details",
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          priceRow("Price (1 item)", serviceAmount),
          const SizedBox(height: 8),
          priceRow("Platform Fee", platformFee),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text("₹$totalAmount.00",
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget priceRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(color: Colors.grey.shade700)),
        Text("₹$value.00",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ================= BOTTOM =================

  Widget bottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "₹$totalAmount.00",
              style: GoogleFonts.inter(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentScreen(
                    totalAmount: totalAmount,
                  ),
                ),
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Continue",
              style: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ================= COMMON CARD =================

  Widget card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: child,
    );
  }
}
