import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class SurnameField extends StatelessWidget {
  const SurnameField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: 'Фамилия',
          hintStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 16,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kcPrimaryColor,
            ),
          ),
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }
}
