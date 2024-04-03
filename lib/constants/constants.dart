import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color backroundColor = Colors.grey.shade100;
showSnackbar(context, String text, Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: textColor,
        ),
      ),
    ),
  );
}
