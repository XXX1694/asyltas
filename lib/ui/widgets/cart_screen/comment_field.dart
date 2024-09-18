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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(
          fontFamily: 'Gilroy',
          color: newBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: newMainColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Gilroy',
            color: newBlack54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
