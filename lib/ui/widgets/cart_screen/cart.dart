import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartBlock extends StatelessWidget {
  const CartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Продукт',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Text(
              'Цена',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Text(
              'Количество',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Text(
              'Итого',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
        const Divider(
          height: 1,
          color: Colors.black45,
        ),
        const SizedBox(height: 35),
        const Center(
          child: Text('Пусто'),
        ),
        const SizedBox(height: 35),
        const Divider(
          height: 1,
          color: Colors.black45,
        ),
        const SizedBox(height: 35),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '    Итого',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                Text(
                  '0 ₸    ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 30),
        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 66,
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Оплатить',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
