import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogTopText extends StatelessWidget {
  const CatalogTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Каталог',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 42,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Главная > Каталог',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
