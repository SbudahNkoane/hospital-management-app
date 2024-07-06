// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Models/patient.dart';
import 'package:hospital_management/Routes/routes.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:hospital_management/Views/Widgets/app_buttons.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:hospital_management/Views/Widgets/text_form_field.dart';
import 'package:hospital_management/Views/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool hideText = true;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 35, right: 35, top: 25, bottom: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome\nBack!",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          "Good to see you again.",
                          style: TextStyle(
                            color: Color(0xFFD9458D),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2C3847),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          ApplicationTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            labelText: 'Email Address',
                            hasIconButton: false,
                            prefixIcon: Icons.mail_outline,
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            obscureText: hideText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            suffixIcon: hideText == false
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                            onSuffixIconPressed: () {
                              setState(() {
                                hideText = !hideText;
                              });
                            },
                            labelText: 'Password',
                            hasIconButton: true,
                            prefixIcon: Icons.key_sharp,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    RouteManager.passwordResetPage,
                                  );
                                },
                                child: const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 69, 104, 217),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ApplicationPrimaryButton(
                            onPressed: () async {
                              if (_loginFormKey.currentState!.validate()) {
                                String result = await context
                                    .read<Authentication>()
                                    .loginUser(
                                      _usernameController.text.trim(),
                                      _passwordController.text.trim(),
                                    );

                                if (result == 'OK') {
                                  //Check if there is a user logged in
                                  if (context
                                          .read<Authentication>()
                                          .currentUser !=
                                      null) {
                                    //if there is a user logged in - Check if its an Admin
                                    if (context
                                                .read<Authentication>()
                                                .currentUser!
                                                .displayName ==
                                            null ||
                                        context
                                            .read<Authentication>()
                                            .currentUser!
                                            .displayName!
                                            .isEmpty) {
                                      //If the logged in account is not admin then get data from Patients Table
                                      Patient? patientData = await context
                                          .read<PatientManagement>()
                                          .getPatientData(context
                                              .read<Authentication>()
                                              .currentUser!
                                              .uid);
                                      if (patientData != null) {
                                        Navigator.of(context).popAndPushNamed(
                                            RouteManager.homePage);
                                      } else {
                                        showErrorSnackBar(context,
                                            message: "Account data not found",
                                            title: "Could not find data");
                                      }
                                    } else {
                                      Admin? adminData = await context
                                          .read<AdminManagement>()
                                          .getAdminData(context
                                              .read<Authentication>()
                                              .currentUser!
                                              .uid);
                                      if (adminData != null) {
                                        Navigator.of(context).popAndPushNamed(
                                            RouteManager.homePage);
                                      } else {
                                        showErrorSnackBar(context,
                                            message: "Account data not found",
                                            title: "Could not find data");
                                      }
                                    }
                                  }
                                } else {
                                  showErrorSnackBar(context,
                                      message: result,
                                      title: "Could not sign in");
                                }
                              }
                            },
                            width: 300,
                            height: 50,
                            child: const Text("Sign me in"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Don't have an account?"),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD9458D),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ApplicationSecondaryButton(
                                  backgroundColor: const Color(0xFFD9458D),
                                  child: const Text(
                                    "Patient",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        RouteManager.patientRegistrationPage);
                                  },
                                ),
                                ApplicationSecondaryButton(
                                  backgroundColor: const Color(0xFF2C3847),
                                  child: const Text(
                                    "Admin",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        RouteManager.adminRegisterPage);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<Authentication, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.showProgress, value.userProgressText),
            builder: (context, value, child) {
              return value.item1
                  ? LoadingScreen(text: "${value.item2}")
                  : Container();
            },
          ),
          Selector<PatientManagement, Tuple2>(
            selector: (context, value) =>
                Tuple2(value.showProgress, value.userProgressText),
            builder: (context, value, child) {
              return value.item1
                  ? LoadingScreen(text: "${value.item2}")
                  : Container();
            },
          ),
          Selector<AdminManagement, Tuple2>(
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
