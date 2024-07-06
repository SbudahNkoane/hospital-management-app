// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/appointment.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:provider/provider.dart';

class AdminAppointmentViewPage extends StatefulWidget {
  const AdminAppointmentViewPage({super.key});

  @override
  State<AdminAppointmentViewPage> createState() =>
      _AdminAppointmentViewPageState();
}

class _AdminAppointmentViewPageState extends State<AdminAppointmentViewPage> {
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
        title: context.read<AppointmentManagement>().allAppointments.isEmpty
            ? const SizedBox()
            : Selector<AppointmentManagement, Appointment>(
                selector: (p0, p1) => p1.allAppointments[
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
          child: context.read<AppointmentManagement>().allAppointments.isEmpty
              ? const SizedBox()
              : Selector<AppointmentManagement, Appointment>(
                  selector: (context, p1) => p1.allAppointments[context
                      .read<AppointmentManagement>()
                      .appointmentClicked!],
                  builder: (context, appointment, child) {
                    return Column(
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
                              "${appointment.appointmentTime.toDate().hour}:${appointment.appointmentTime.toDate().minute}",
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
                          appointment.review == null
                              ? "No Review"
                              : "Hospital Attended:",
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
                                  hintText:
                                      appointment.review!.hospitalAttended,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          appointment.review == null ? "" : "Review:",
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
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        appointment.review == null
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
                                      backgroundColor:
                                          const Color.fromARGB(255, 255, 0, 0),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Review'),
                                            content: const Text(
                                              'Are you sure you want to delete this review??',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  context
                                                      .read<
                                                          AppointmentManagement>()
                                                      .deleteReview(
                                                          appointment.apId!);
                                                  showSuccessSnackBar(
                                                    context,
                                                    message: 'Review Deleted',
                                                  );
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text("Delete Review"),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fixedSize: const Size(300, 50),
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 0, 0),
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Appointment'),
                                      content: const Text(
                                        'Are you sure you want to delete this appointment??',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context, 'Ok');

                                            Navigator.of(context).pop();

                                            context
                                                .read<AppointmentManagement>()
                                                .deleteAppointment(
                                                    appointment.apId!);

                                            showSuccessSnackBar(context,
                                                message: 'Appointment Deleted');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("Delete Appointment"),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
