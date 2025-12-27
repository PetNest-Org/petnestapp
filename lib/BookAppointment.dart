import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'OrderSummary.dart';
import 'VetBooking.dart';
 // for Doctor model (adjust path if needed)

class BookAppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  final String visitType; // "Clinic" or "Home"

  const BookAppointmentScreen({
    super.key,
    required this.doctor,
    required this.visitType,
  });

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = -1;

  final List<String> dates = ["Today", "Tomorrow", "Oct 24"];
  final List<String> timeSlots = [
    "09:00 AM",
    "11:00 AM",
    "02:00 PM",
    "04:00 PM",
    "06:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: Text(
          "Book Appointment",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 VISIT SUMMARY CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.visitType} Visit with ${widget.doctor.name}",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "with ${widget.doctor.name}",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 SELECT DATE
              Text(
                "Select Date",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: List.generate(dates.length, (index) {
                  final selected = index == selectedDateIndex;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF2563EB)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF2563EB)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dates[index],
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              /// 🔹 SELECT TIME SLOT
              Text(
                "Select Time Slot",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              /// RESPONSIVE GRID
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: timeSlots.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.6,
                ),
                itemBuilder: (context, index) {
                  final selected = index == selectedTimeIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF2563EB)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF2563EB)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          timeSlots[index],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const Spacer(),

              /// 🔹 CONFIRM BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedTimeIndex == -1
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderSummaryScreen(
                          doctor: widget.doctor,
                          visitType: widget.visitType,
                          selectedDate: dates[selectedDateIndex],
                          selectedTime: timeSlots[selectedTimeIndex],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTimeIndex == -1
                        ? Colors.grey.shade300
                        : Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Confirm & Proceed",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: selectedTimeIndex == -1
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
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
