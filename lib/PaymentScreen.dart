import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  final int totalAmount;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Google Pay";
  static const int codFee = 9;

  bool get isCOD => selectedMethod == "COD";

  int get finalAmount =>
      isCOD ? widget.totalAmount + codFee : widget.totalAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Step 3 of 3 - Payments",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          totalAmountBar(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  upiCard(),
                  const SizedBox(height: 16),
                  cardPaymentOption(),
                  const SizedBox(height: 16),
                  cashOnDeliveryOption(),
                ],
              ),
            ),
          ),

          payButton(),
        ],
      ),
    );
  }

  // ================= TOTAL =================

  Widget totalAmountBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Amount",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "₹$finalAmount.00",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  // ================= UPI =================

  Widget upiCard() {
    return paymentContainer(
      child: Column(
        children: [
          sectionHeader("UPI"),
          radioTile("Google Pay"),
          divider(),
          radioTile("PhonePe"),
          divider(),
          radioTile("Add new UPI ID"),
        ],
      ),
    );
  }

  Widget radioTile(String title) {
    return RadioListTile<String>(
      value: title,
      groupValue: selectedMethod,
      onChanged: (val) => setState(() => selectedMethod = val!),
      activeColor: Colors.blue,
      title: Text(
        title,
        style: GoogleFonts.inter(fontWeight: FontWeight.w500),
      ),
    );
  }

  // ================= CARD =================

  Widget cardPaymentOption() {
    return paymentTile(
      title: "Credit / Debit / ATM Card",
      icon: Icons.credit_card,
      value: "CARD",
    );
  }

  // ================= COD =================

  Widget cashOnDeliveryOption() {
    return paymentContainer(
      child: RadioListTile<String>(
        value: "COD",
        groupValue: selectedMethod,
        onChanged: (val) => setState(() => selectedMethod = val!),
        activeColor: Colors.blue,
        secondary: const Icon(Icons.payments_outlined),
        title: Text(
          "Cash on Delivery",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        subtitle: isCOD
            ? Text(
          "A fee of ₹9 will be charged",
          style: GoogleFonts.inter(
            color: Colors.orange,
            fontSize: 13,
          ),
        )
            : null,
      ),
    );
  }

  // ================= PAY BUTTON =================

  Widget payButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: showConfirmationDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            isCOD ? "Place Order" : "Pay ₹$finalAmount.00",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ================= DIALOG =================

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        title: Text(
          "Confirm Payment",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Method: $selectedMethod",
                style: GoogleFonts.inter()),
            const SizedBox(height: 8),
            Text("Total Amount: ₹$finalAmount.00",
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Place order / trigger payment
            },
            child: Text(isCOD ? "Place Order" : "Pay Now"),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

  Widget paymentTile({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return paymentContainer(
      child: RadioListTile<String>(
        value: value,
        groupValue: selectedMethod,
        onChanged: (val) => setState(() => selectedMethod = val!),
        activeColor: Colors.blue,
        secondary: Icon(icon),
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget paymentContainer({required Widget child}) {
    return Container(
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

  Widget sectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget divider() =>
      Divider(height: 1, color: Colors.grey.shade300);
}
