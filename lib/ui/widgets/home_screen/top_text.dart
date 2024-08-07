import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopText extends StatelessWidget {
  const TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Новое поступление',
          style: GoogleFonts.montserrat(
            color: kcBlack,
            fontSize: 46,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Товары различных категорий от камней \nдо ручных изделий',
          style: GoogleFonts.poppins(
            color: kcLightGrey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
