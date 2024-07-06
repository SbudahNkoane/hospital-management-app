import 'package:flutter/material.dart';
import 'package:hospital_management/Routes/routes.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Appointment%20Management/appointment_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientManagement(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentManagement(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminManagement(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospital Management',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color(0xFFD9458D),
          ),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF005DF4),
          ),
          useMaterial3: true,
        ),
        initialRoute: RouteManager.splashPage,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
