import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 160),
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_small.png',
            height: 47,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 13,
              ),
              child: Center(
                child: Text(
                  'Главная',
                  style: GoogleFonts.montserrat(
                    color: kcPrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 13,
              ),
              child: Center(
                child: Text(
                  'Каталог',
                  style: GoogleFonts.montserrat(
                    color: kcPrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 13,
              ),
              child: Center(
                child: Text(
                  'Скидки',
                  style: GoogleFonts.montserrat(
                    color: kcPrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 13,
              ),
              child: Center(
                child: Text(
                  'Войти',
                  style: GoogleFonts.montserrat(
                    color: kcPrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(left: 25),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 20),
                    color: kcBlack.withOpacity(0.15),
                    blurRadius: 15,
                  ),
                ],
                color: kcPrimaryColor,
              ),
              child: Center(
                child: Text(
                  'Регестрация',
                  style: GoogleFonts.montserrat(
                    color: kcWhite,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
