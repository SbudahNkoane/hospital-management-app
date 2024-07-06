// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Models/appointment.dart';
import 'package:hospital_management/Models/patient.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:hospital_management/Views/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage({super.key});

  @override
  State<AppointmentBookingPage> createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  late TextEditingController _reasonController;
  late TextEditingController _timeController;
  late TextEditingController _dateController;
  final GlobalKey<FormState> _patientBookingFormKey = GlobalKey<FormState>();
  TimeOfDay? appointmentTime;
  DateTime? appointmentDate;
  @override
  void initState() {
    _reasonController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Image.asset("assets/logo/logo_white.png"),
          ],
        ),
        toolbarHeight: 150,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                  right: BorderSide(),
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: context.read<Authentication>().currentUser!.displayName ==
                      null
                  ? Selector<PatientManagement, Patient>(
                      selector: (p0, p1) => p1.patientData!,
                      builder: (context, patient, child) {
                        return Form(
                          key: _patientBookingFormKey,
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                color: const Color(0xFF2C3847),
                                child: Center(
                                  child: Text(
                                    "Patient Information",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "First Name:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "Surname:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(patient.firstName),
                                  Text(patient.surname),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ID Number",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "Contact Number:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(patient.idNumber),
                                  Text(patient.contactNumber),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: const Size(100, 50),
                                      backgroundColor: const Color(0xFFD9458D),
                                      foregroundColor: const Color(0xFFFFFFFF),
                                    ),
                                    onPressed: () async {
                                      appointmentDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024, 12),
                                      );
                                      setState(() {
                                        _dateController
                                            .text = appointmentDate !=
                                                null
                                            ? "${appointmentDate!.month}/${appointmentDate!.day}/${appointmentDate!.year}"
                                            : "";
                                      });
                                    },
                                    child: const Text(
                                      "Pick Date",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: const Size(100, 50),
                                      foregroundColor: const Color(0xFFFFFFFF),
                                      backgroundColor: const Color(0xFF2C3847),
                                    ),
                                    onPressed: () async {
                                      appointmentTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      setState(() {
                                        _timeController
                                            .text = appointmentTime !=
                                                null
                                            ? "${appointmentTime!.hour}:${appointmentTime!.minute}"
                                            : "";
                                      });
                                    },
                                    child: const Text(
                                      "Pick Time",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _dateController,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _timeController,
                                      keyboardType: TextInputType.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Please describe a reason for this visit:",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF2C3847),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextFormField(
                                maxLength: 250,
                                maxLines: 10,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please provide the reason your visit';
                                  }
                                  return null;
                                },
                                controller: _reasonController,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 251, 0, 0),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 250, 20, 3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xFFD9458D),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                  if (appointmentDate == null ||
                                      appointmentTime == null) {
                                    showErrorSnackBar(
                                      context,
                                      message:
                                          'Please provide Appoinment Date/Time',
                                      title: 'Required',
                                    );
                                  } else {
                                    if (_patientBookingFormKey.currentState!
                                        .validate()) {
                                      Appointment newAppointment = Appointment(
                                        ownerId: context
                                            .read<Authentication>()
                                            .currentUser!
                                            .uid,
                                        appointmentTime: Timestamp.fromDate(
                                          DateTime(
                                            appointmentDate!.year,
                                            appointmentDate!.month,
                                            appointmentDate!.day,
                                            appointmentTime!.hour,
                                            appointmentTime!.minute,
                                          ),
                                        ),
                                        appointmentReason:
                                            _reasonController.text.trim(),
                                        review: null,
                                      );
                                      String result = await context
                                          .read<AppointmentManagement>()
                                          .scheduleAppointment(newAppointment);
                                      Navigator.of(context).pop();
                                      if (result == 'OK') {
                                        showSuccessSnackBar(
                                          context,
                                          message:
                                              '${patient.firstName} ${patient.surname}, your appointment is recieved',
                                        );
                                      } else {
                                        showErrorSnackBar(
                                          context,
                                          message: result,
                                          title: 'Appointment Error',
                                        );
                                      }
                                    }
                                  }
                                },
                                child: const Text("Schedule now"),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Selector<AdminManagement, Admin>(
                      selector: (p0, p1) => p1.adminData!,
                      builder: (context, admin, child) {
                        return Form(
                          key: _patientBookingFormKey,
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                color: const Color(0xFF2C3847),
                                child: Center(
                                  child: Text(
                                    "Patient Information",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "First Name:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "Surname:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(admin.firstName),
                                  Text(admin.surname),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ID Number",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "Contact Number:",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(admin.idNumber),
                                  Text(admin.contactNumber),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: const Size(100, 50),
                                      backgroundColor: const Color(0xFFD9458D),
                                      foregroundColor: const Color(0xFFFFFFFF),
                                    ),
                                    onPressed: () async {
                                      appointmentDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024, 12),
                                      );
                                      setState(() {
                                        _dateController
                                            .text = appointmentDate !=
                                                null
                                            ? "${appointmentDate!.month}/${appointmentDate!.day}/${appointmentDate!.year}"
                                            : "";
                                      });
                                      if (appointmentDate != null) {}
                                    },
                                    child: const Text(
                                      "Pick Date",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: const Size(100, 50),
                                      foregroundColor: const Color(0xFFFFFFFF),
                                      backgroundColor: const Color(0xFF2C3847),
                                    ),
                                    onPressed: () async {
                                      appointmentTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      setState(() {
                                        _timeController
                                            .text = appointmentTime !=
                                                null
                                            ? "${appointmentTime!.hour}:${appointmentTime!.minute}"
                                            : "";
                                      });
                                    },
                                    child: const Text(
                                      "Pick Time",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _dateController,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _timeController,
                                      keyboardType: TextInputType.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Please describe a reason for this visit:",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF2C3847),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextFormField(
                                maxLength: 250,
                                maxLines: 10,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please provide the reason your visit';
                                  }
                                  return null;
                                },
                                controller: _reasonController,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 251, 0, 0),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 250, 20, 3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xFFD9458D),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                  if (appointmentDate == null ||
                                      appointmentTime == null) {
                                    showErrorSnackBar(
                                      context,
                                      message:
                                          'Please provide Appoinment Date/Time',
                                      title: 'Required',
                                    );
                                  } else {
                                    if (_patientBookingFormKey.currentState!
                                        .validate()) {
                                      Appointment newAppointment = Appointment(
                                        ownerId: context
                                            .read<Authentication>()
                                            .currentUser!
                                            .uid,
                                        appointmentTime: Timestamp.fromDate(
                                          DateTime(
                                            appointmentDate!.year,
                                            appointmentDate!.month,
                                            appointmentDate!.day,
                                            appointmentTime!.hour,
                                            appointmentTime!.minute,
                                          ),
                                        ),
                                        appointmentReason:
                                            _reasonController.text.trim(),
                                        review: null,
                                      );
                                      String result = await context
                                          .read<AppointmentManagement>()
                                          .scheduleAppointment(newAppointment);
                                      Navigator.of(context).pop();
                                      if (result == 'OK') {
                                        showSuccessSnackBar(
                                          context,
                                          message:
                                              '${admin.firstName} ${admin.surname}, your appointment is recieved',
                                        );
                                      } else {
                                        showErrorSnackBar(
                                          context,
                                          message: result,
                                          title: 'Appointment Error',
                                        );
                                      }
                                    }
                                  }
                                },
                                child: const Text("Schedule now"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          Selector<AppointmentManagement, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.showProgress, value.userProgressText),
            builder: (context, value, child) {
              return value.item1
                  ? LoadingScreen(text: "${value.item2}")
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
