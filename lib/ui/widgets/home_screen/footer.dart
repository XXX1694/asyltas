import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 140,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 140 * deviceWidth / 2200,
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              Image.asset(
                'assets/images/logo_small.png',
                height: 37,
              ),
              const Spacer(),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                child: Text(
                  'Поддержка',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 80),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                child: Text(
                  'Оплата',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 80),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                child: Text(
                  'Контакты',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Copyright © 2024 galab.kz . All Rights Reseved.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
