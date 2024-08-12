import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTopText extends StatelessWidget {
  const CartTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Корзина',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 42,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Главная > Корзина',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
