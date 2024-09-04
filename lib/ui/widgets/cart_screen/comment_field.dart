import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CommentTextField({
    super.key,
    required this.controller,
    this.hintText = 'Коментарий к заказу',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        maxLines: 3,
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
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 14,
            letterSpacing: -0.41,
          ),
          contentPadding: const EdgeInsets.all(12.0),
        ),
      ),
    );
  }
}
