import 'package:flutter/material.dart';
import 'package:hospital_management/Views/Admin/admin_panel_page.dart';
import 'package:hospital_management/Views/Admin/admin_register_page.dart';
import 'package:hospital_management/Views/Admin/admin_view_appointment_page.dart';
import 'package:hospital_management/Views/Patient/patient_register_page.dart';
import 'package:hospital_management/Views/appointment_booking_page.dart';
import 'package:hospital_management/Views/appointment_view_page.dart';
import 'package:hospital_management/Views/home_page.dart';

import 'package:hospital_management/Views/login_page.dart';
import 'package:hospital_management/Views/my_appointments_page.dart';
import 'package:hospital_management/Views/password_reset_page.dart';
import 'package:hospital_management/Views/profile_page.dart';
import 'package:hospital_management/Views/splash.dart';

class RouteManager {
  // ===========================App Level Screens =============================================
  static const String splashPage = '/';
  static const String loginPage = '/Login';
  static const String passwordResetPage = '/ResetPassword';
  static const String homePage = '/HomePage';
  static const String myAppointmentsPage = '/MyAppointmentsPage';
  static const String profilePage = '/AppointmentProfilePage';
  static const String appointmentBookingPage = '/AppointmentBookingPage';
  static const String appointmentViewPage = '/PatientAppointmentViewPage';

// ========================== Patient Screens =================================================
  static const String patientRegistrationPage = '/PatientRegistrationPage';

//========================== Admin Screens ====================================================
  static const String adminPanelPage = '/AdminPanelPage';
  static const String adminRegisterPage = '/AdminRegisterPage';
  static const String adminAppointmentViewPage = '/AdminAppointmentViewPage';

  RouteManager._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ========================== Admin Screens ============================================

      // ========================== App Level Screens ========================================
      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case appointmentBookingPage:
        return MaterialPageRoute(
          builder: (context) => const AppointmentBookingPage(),
        );
      case myAppointmentsPage:
        return MaterialPageRoute(
          builder: (context) => const MyAppointmentsPage(),
        );
      case appointmentViewPage:
        return MaterialPageRoute(
          builder: (context) => const AppointmentViewPage(),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case passwordResetPage:
        return MaterialPageRoute(
          builder: (context) => const PasswordResetPage(),
        );
      //========================== Patient Screens ===========================================
      case patientRegistrationPage:
        return MaterialPageRoute(
          builder: (context) => const PatientRegistrationPage(),
        );

      //========================== Admin Screens =============================================

      case adminAppointmentViewPage:
        return MaterialPageRoute(
          builder: (context) => const AdminAppointmentViewPage(),
        );
      case adminPanelPage:
        return MaterialPageRoute(
          builder: (context) => const AdminPanelPage(),
        );
      case adminRegisterPage:
        return MaterialPageRoute(
          builder: (context) => const AdminRegisterPage(),
        );
      default:
        throw const FormatException('Route not found');
    }
  }
}
