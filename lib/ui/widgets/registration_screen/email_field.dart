import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: 'Эл. Почта',
          hintStyle: GoogleFonts.montserrat(
            color: Colors.black54,
            fontSize: 16,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kcPrimaryColor,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
