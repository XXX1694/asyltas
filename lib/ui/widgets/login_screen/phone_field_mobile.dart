import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneFieldMobile extends StatelessWidget {
  const PhoneFieldMobile({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: kcPrimaryColor,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          hintText: 'Номер заказчика (обязательно)',
          hintStyle: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
      ),
    );
  }
}

var maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
