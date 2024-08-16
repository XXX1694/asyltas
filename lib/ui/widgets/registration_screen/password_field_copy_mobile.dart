import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordFieldCopyMobile extends StatefulWidget {
  const PasswordFieldCopyMobile({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordFieldCopyMobile> createState() =>
      _PasswordFieldCopyMobileState();
}

class _PasswordFieldCopyMobileState extends State<PasswordFieldCopyMobile> {
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
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          suffixIcon: CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => setState(() {
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
            fontSize: 14,
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
