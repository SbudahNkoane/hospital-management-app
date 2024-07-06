// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Models/patient.dart';
import 'package:hospital_management/Routes/routes.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:hospital_management/Views/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        leadingWidth: 110,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              //  color: Colors.amber,
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: Image.asset(
              "assets/logo/logo_blue.png",
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.read<Authentication>().currentUser!.displayName == null
                ? Selector<PatientManagement, Patient>(
                    selector: (p0, p1) => p1.patientData!,
                    builder: (context, value, child) {
                      return Text(
                        "Hello ${value.firstName}",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF2C3847),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    },
                  )
                : Selector<AdminManagement, Admin>(
                    selector: (p0, p1) => p1.adminData!,
                    builder: (context, value, child) {
                      return Text(
                        "Hello ${value.firstName}",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF2C3847),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    },
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "We are here, for you",
              style: GoogleFonts.poppins(
                color: const Color(0xFFD9458D),
                fontSize: 12,
              ),
            ),
          ],
        ),
        toolbarHeight: 150,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(35),
                height: MediaQuery.of(context).size.height + 20,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome home",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/illustration/Doctors.png",
                    ),
                    Row(
                      mainAxisAlignment: context
                                      .read<Authentication>()
                                      .currentUser!
                                      .displayName !=
                                  null &&
                              context
                                  .read<Authentication>()
                                  .currentUser!
                                  .displayName!
                                  .isNotEmpty
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          color: const Color(0xFF2C3847),
                          child: InkWell(
                            onTap: () async {
                              String result = await context
                                  .read<AppointmentManagement>()
                                  .getMyAppointments(context
                                      .read<Authentication>()
                                      .currentUser!
                                      .uid);
                              if (result == 'OK') {
                                Navigator.of(context).pushNamed(
                                  RouteManager.myAppointmentsPage,
                                );
                              } else {
                                showErrorSnackBar(
                                  context,
                                  message: result,
                                  title: "Could not get appointments",
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/illustration/Date_picker.png",
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    "My Appointments",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        context
                                        .read<Authentication>()
                                        .currentUser!
                                        .displayName !=
                                    null &&
                                context
                                    .read<Authentication>()
                                    .currentUser!
                                    .displayName!
                                    .isNotEmpty
                            ? Card(
                                elevation: 1,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: InkWell(
                                  onTap: () async {
                                    await context
                                        .read<AppointmentManagement>()
                                        .getAllAppointments();
                                    Navigator.of(context).pushNamed(
                                      RouteManager.adminPanelPage,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    height: 200,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/illustration/Vault.png",
                                          height: 100,
                                          width: 100,
                                        ),
                                        Text(
                                          "Admin Panel",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF2C3847),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 10,
                          color: const Color(0xFFD9458D),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                RouteManager.profilePage,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/illustration/Profile.png",
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    "My Profile",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          child: InkWell(
                            onTap: () async {
                              await context.read<Authentication>().logoutUser();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouteManager.loginPage, (route) => false);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 200,
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/illustration/Profile.png",
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    "Log out",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF2C3847),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
