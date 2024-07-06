// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/Views/Widgets/app_snackbars.dart';
import 'package:provider/provider.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late TextEditingController _usernameController;
  bool linkSent = false;
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 35),
            child: linkSent
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/illustration/Mail_sent.png"),
                      Text(
                        "A password reset link has\nbeen sent to your email.",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF2C3847),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Password",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF2C3847),
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            "Enter an email linked with your account.\nIf there is an existing account that matches the email provided, we will send password reset instructions.",
                            style: TextStyle(
                              color: Color(0xFF2C3847),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: _resetFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                return null;
                              },
                              controller: _usernameController,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 251, 0, 0),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 251, 0, 0),
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
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF2C3847),
                                  ),
                                  labelText: 'Email Address'),
                            ),
                            const SizedBox(
                              height: 20,
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
                                if (_resetFormKey.currentState!.validate()) {
                                  String result = await context
                                      .read<Authentication>()
                                      .resetPassword(
                                          _usernameController.text.trim());
                                  if (result == 'OK') {
                                    setState(() {
                                      linkSent = true;
                                    });
                                  } else {
                                    showErrorSnackBar(context,
                                        message: result, title: 'Error');
                                  }
                                }
                              },
                              child: const Text("Reset Password"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
