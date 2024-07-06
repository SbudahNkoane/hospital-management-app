// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/patient.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/Views/Widgets/app_buttons.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:hospital_management/Views/Widgets/text_form_field.dart';
import 'package:hospital_management/Views/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({super.key});

  @override
  State<PatientRegistrationPage> createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  late TextEditingController _patientFirstnameController;
  late TextEditingController _patientSurnameController;
  late TextEditingController _patientEmailController;
  late TextEditingController _patientPasswordController;
  late TextEditingController _patientIdNumberController;
  late TextEditingController _patientDateOfBirthController;
  late TextEditingController _patientContactNumberController;
  final GlobalKey<FormState> _patientRegisterFormKey = GlobalKey<FormState>();
  bool hideText = true;

  @override
  void initState() {
    _patientFirstnameController = TextEditingController();
    _patientSurnameController = TextEditingController();
    _patientContactNumberController = TextEditingController();
    _patientDateOfBirthController = TextEditingController();
    _patientEmailController = TextEditingController();
    _patientIdNumberController = TextEditingController();
    _patientPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _patientSurnameController.dispose();
    _patientFirstnameController.dispose();
    _patientContactNumberController.dispose();
    _patientDateOfBirthController.dispose();
    _patientEmailController.dispose();
    _patientPasswordController.dispose();
    _patientIdNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFD9458D),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  right: 35,
                  top: 35,
                  bottom: 35,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          "We are happy to see you here.",
                          style: TextStyle(
                            color: Color(0xFFD9458D),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _patientRegisterFormKey,
                      child: Column(
                        children: [
                          ApplicationTextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              } else if (value.length < 2) {
                                return 'Please enter valid name';
                              }
                              return null;
                            },
                            labelText: 'First Name',
                            hasIconButton: false,
                            prefixIcon: Icons.person_3,
                            controller: _patientFirstnameController,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your surname';
                              } else if (value.length < 2) {
                                return 'Please enter valid surname';
                              }
                              return null;
                            },
                            labelText: 'Surname',
                            hasIconButton: false,
                            prefixIcon: Icons.person_3,
                            controller: _patientSurnameController,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!value.contains('@')) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                            labelText: 'Email Address',
                            hasIconButton: false,
                            prefixIcon: Icons.alternate_email,
                            controller: _patientEmailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            maxLength: 13,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your id number';
                              } else if (value.length < 13) {
                                return 'Please enter valid id number';
                              }
                              return null;
                            },
                            labelText: 'ID Number',
                            hasIconButton: false,
                            prefixIcon: Icons.remember_me,
                            controller: _patientIdNumberController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your date of birth';
                              } else if (value.length < 10) {
                                return 'Please enter valid date of birth';
                              }
                              return null;
                            },
                            labelText: 'Date Of Birth',
                            hasIconButton: false,
                            suffix: const Text("dd/mm/yyyy"),
                            prefixIcon: Icons.calendar_month,
                            controller: _patientDateOfBirthController,
                            keyboardType: TextInputType.datetime,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your contact number';
                              } else if (value.length < 10) {
                                return 'Please enter valid contact number';
                              }
                              return null;
                            },
                            labelText: 'Contact Number',
                            hasIconButton: false,
                            prefixIcon: Icons.call,
                            controller: _patientContactNumberController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            obscureText: hideText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must must be atleast 8 characters';
                              } else if (!value.contains('@')) {
                                return 'Password must must have @ sign';
                              }
                              return null;
                            },
                            labelText: 'Password',
                            hasIconButton: true,
                            suffixIcon: hideText == false
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                            onSuffixIconPressed: () {
                              setState(() {
                                hideText = !hideText;
                              });
                            },
                            prefixIcon: Icons.private_connectivity,
                            controller: _patientPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplicationTextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else if (_patientPasswordController.text
                                      .trim() !=
                                  value.trim()) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            labelText: 'Confirm Password',
                            hasIconButton: false,
                            prefixIcon: Icons.private_connectivity_outlined,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ApplicationPrimaryButton(
                            onPressed: () async {
                              if (_patientRegisterFormKey.currentState!
                                  .validate()) {
                                Patient patient = Patient(
                                  firstName:
                                      _patientFirstnameController.text.trim(),
                                  surname:
                                      _patientSurnameController.text.trim(),
                                  idNumber:
                                      _patientIdNumberController.text.trim(),
                                  emailaddress:
                                      _patientEmailController.text.trim(),
                                  dateOfBirth: Timestamp.fromDate(
                                    DateTime(
                                      int.parse(
                                        _patientDateOfBirthController.text
                                            .trim()
                                            .substring(6, 10),
                                      ),
                                      int.parse(
                                        _patientDateOfBirthController.text
                                            .trim()
                                            .substring(3, 5),
                                      ),
                                      int.parse(
                                        _patientDateOfBirthController.text
                                            .trim()
                                            .substring(0, 2),
                                      ),
                                    ),
                                  ),
                                  contactNumber: _patientContactNumberController
                                      .text
                                      .trim(),
                                  role: 'Patient',
                                );

                                String result = await context
                                    .read<Authentication>()
                                    .registerUser(
                                      _patientPasswordController.text.trim(),
                                      patient,
                                    );
                                if (result == 'OK') {
                                  Navigator.of(context).pop();
                                  showSuccessSnackBar(context,
                                      message: 'You have been Registered');
                                } else {
                                  showErrorSnackBar(context,
                                      message: result,
                                      title: "Oops!Could not Sign you up!!");
                                }
                              }
                            },
                            width: 300,
                            height: 50,
                            child: const Text("Sign me up"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<Authentication, Tuple2>(
            selector: (context, value) => Tuple2(
              value.showProgress,
              value.userProgressText,
            ),
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
