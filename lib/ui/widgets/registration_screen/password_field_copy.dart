import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordFieldCopy extends StatefulWidget {
  const PasswordFieldCopy({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordFieldCopy> createState() => _PasswordFieldCopyState();
}

class _PasswordFieldCopyState extends State<PasswordFieldCopy> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          suffixIcon: GestureDetector(
            onTap: () => setState(() {
              _obscureText = !_obscureText;
            }),
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
              size: 24,
            ),
          ),
          hintText: 'Подтвердить пароль',
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
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
