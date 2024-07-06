// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Routes/routes.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:hospital_management/firebase_options.dart';
import 'package:provider/provider.dart';

class InitializeApp {
  static initializeApp(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (context.mounted == true) {
        if (user == null) {
          Navigator.of(context).popAndPushNamed(RouteManager.loginPage);
        } else {
          context.read<Authentication>().setCurrentUser(user);
          if (user.displayName == null) {
            var patientData =
                await context.read<PatientManagement>().getPatientData(
                      context.read<Authentication>().currentUser!.uid,
                    );
            if (patientData != null) {
              Navigator.of(context).popAndPushNamed(RouteManager.homePage);
            } else {
              Navigator.of(context).popAndPushNamed(RouteManager.loginPage);
            }
          } else {
            Admin? adminData = await context
                .read<AdminManagement>()
                .getAdminData(context.read<Authentication>().currentUser!.uid);
            if (adminData != null) {
              Navigator.of(context).popAndPushNamed(RouteManager.homePage);
            }
            //  await context.read<UserManager>().getCurrentUserData(
            //    context.read<UserAuthentication>().currentUser!.uid);
            // Navigator.of(context).popAndPushNamed(AppRouteManager.userHomePage);
          }
        }
      }
    });
  }
}
