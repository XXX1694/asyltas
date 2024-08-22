import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class TopText extends StatelessWidget {
  const TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Новое поступление',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: kcBlack,
            fontSize: 46,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Товары различных категорий от камней \nдо ручных изделий',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: kcLightGrey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
