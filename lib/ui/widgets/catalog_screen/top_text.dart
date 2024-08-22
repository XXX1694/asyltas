import 'package:flutter/material.dart';

class CatalogTopText extends StatelessWidget {
  const CatalogTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Каталог',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 42,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Главная > Каталог',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
