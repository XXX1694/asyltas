import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.controller});
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
          hintText: 'Номер телефона',
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
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
      ),
    );
  }
}

var maskFormatter = MaskTextInputFormatter(
    mask: '+7##########', filter: {"#": RegExp(r'[0-9]')});
