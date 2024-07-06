import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccessSnackBar(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    duration: const Duration(
      milliseconds: 2500,
    ),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: const Color.fromARGB(209, 2, 100, 38),
    // Color.fromARGB(209, 44, 56, 71),
    content: Text(
      message,
      style: GoogleFonts.poppins(
        color: const Color(0xFFFFFFFF),
        fontSize: 14,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(
  BuildContext context, {
  required String message,
  required String title,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(
      milliseconds: 2500,
    ),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: const Color.fromARGB(255, 251, 0, 0),
    content: ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: const Color(0xFFFFFFFF),
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text(
        message,
        style: GoogleFonts.poppins(
          color: const Color(0xFFFFFFFF),
          fontSize: 12,
        ),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
