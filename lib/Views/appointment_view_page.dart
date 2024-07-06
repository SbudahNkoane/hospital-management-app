// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/appointment.dart';
import 'package:hospital_management/Models/review.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:hospital_management/Views/Widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class AppointmentViewPage extends StatefulWidget {
  const AppointmentViewPage({super.key});

  @override
  State<AppointmentViewPage> createState() => _AppointmentViewPageState();
}

class _AppointmentViewPageState extends State<AppointmentViewPage> {
  late TextEditingController _hospitalController;
  late TextEditingController _reviewController;
  final GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    _hospitalController = TextEditingController();
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _hospitalController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        automaticallyImplyLeading: false,
        title: Selector<AppointmentManagement, Appointment>(
          selector: (p0, p1) => p1.myAppointments[
              context.read<AppointmentManagement>().appointmentClicked!],
          builder: (context, value, child) {
            return Text(
              "Date: ${value.appointmentTime.toDate().month}/${value.appointmentTime.toDate().day}/${value.appointmentTime.toDate().year}",
              style: GoogleFonts.poppins(
                color: const Color(0xFF2C3847),
                fontSize: 20,
              ),
            );
          },
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
            top: 25,
          ),
          child: Selector<AppointmentManagement, Appointment>(
            selector: (p0, p1) => p1.myAppointments[
                context.read<AppointmentManagement>().appointmentClicked!],
            builder: (context, appointment, child) {
              return Form(
                key: _bookingFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      color: const Color(0xFFD9458D),
                      child: Center(
                        child: Text(
                          "Appointment Information",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Time:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          appointment.appointmentTime.toDate().hour > 11
                              ? "${appointment.appointmentTime.toDate().hour}:${appointment.appointmentTime.toDate().minute} PM"
                              : "${appointment.appointmentTime.toDate().hour}:${appointment.appointmentTime.toDate().minute} AM",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reason for visit:",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      appointment.appointmentReason,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      color: const Color(0xFF2C3847),
                      child: Center(
                        child: Text(
                          "Review",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hospital Attended:",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    appointment.review != null
                        ? TextFormField(
                            enabled: false,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: appointment.review!.hospitalAttended,
                            ),
                          )
                        : ApplicationTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide hospital name';
                              }
                              return null;
                            },
                            controller: _hospitalController,
                            labelText: '',
                            hasIconButton: false,
                            prefixIcon: null,
                            keyboardType: TextInputType.text,
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      appointment.review == null
                          ? "Provide your feedback:"
                          : "Review:",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    appointment.review != null
                        ? Text(appointment.review!.review)
                        : ApplicationTextFormField(
                            maxLength: 250,
                            maxLines: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide your feedback';
                              }
                              return null;
                            },
                            controller: _reviewController,
                            labelText: '',
                            hasIconButton: false,
                            prefixIcon: null,
                            keyboardType: TextInputType.multiline,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    appointment.review != null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fixedSize: const Size(300, 50),
                                  foregroundColor: const Color(0xFFFFFFFF),
                                  backgroundColor: const Color(0xFF2C3847),
                                ),
                                onPressed: () async {
                                  if (_bookingFormKey.currentState!
                                      .validate()) {
                                    Review newReview = Review(
                                      hospitalAttended:
                                          _hospitalController.text.trim(),
                                      review: _reviewController.text.trim(),
                                    );
                                    String result = await context
                                        .read<AppointmentManagement>()
                                        .review(
                                          appointment.apId!,
                                          newReview,
                                        );
                                    if (result == 'OK') {
                                      showSuccessSnackBar(context,
                                          message: context
                                                      .read<Authentication>()
                                                      .currentUser!
                                                      .displayName !=
                                                  null
                                              ? '${context.read<AdminManagement>().adminData!.firstName} ${context.read<AdminManagement>().adminData!.surname}, your review is recieved'
                                              : '${context.read<PatientManagement>().patientData!.firstName} ${context.read<PatientManagement>().patientData!.surname}, your review is recieved');
                                    } else {
                                      showErrorSnackBar(
                                        context,
                                        message: result,
                                        title: 'Error saving review',
                                      );
                                    }
                                  }
                                },
                                child: const Text("Review"),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
