import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/appointment.dart';
import 'package:hospital_management/Routes/routes.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:provider/provider.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF2C3847),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/logo/logo_white.png",
            ),
          ],
        ),
        toolbarHeight: 150,
      ),
      body: Selector<AppointmentManagement, List<Appointment>>(
        selector: (p0, p1) => p1.allAppointments,
        builder: (context, appointments, child) {
          return appointments.isNotEmpty
              ? ListView.builder(
                  itemCount: context
                      .read<AppointmentManagement>()
                      .allAppointments
                      .length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 300,
                      child: Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteManager.adminAppointmentViewPage);
                              context
                                  .read<AppointmentManagement>()
                                  .viewAppointment(index);
                            },
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Appointment date",
                                    style: GoogleFonts.poppins(
                                      color:
                                          const Color.fromARGB(255, 44, 56, 71),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Date: ${appointments[index].appointmentTime.toDate().month}/${appointments[index].appointmentTime.toDate().day}/${appointments[index].appointmentTime.toDate().year}",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF2C3847),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.schedule),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        appointments[index]
                                                    .appointmentTime
                                                    .toDate()
                                                    .hour >
                                                11
                                            ? "starts at: ${appointments[index].appointmentTime.toDate().hour}:${appointments[index].appointmentTime.toDate().minute} PM"
                                            : "starts at: ${appointments[index].appointmentTime.toDate().hour}:${appointments[index].appointmentTime.toDate().minute} AM",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF2C3847),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Text(
                                    "Reason for visit",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 217, 69, 141),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    appointments[index].appointmentReason,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/illustration/No_data.png",
                    ),
                    const Text("There are no appointments on the system"),
                  ],
                );
        },
      ),
    );
  }
}
