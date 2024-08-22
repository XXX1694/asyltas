import 'package:flutter/material.dart';

class CartTopText extends StatelessWidget {
  const CartTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Корзина',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 42,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Главная > Корзина',
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
