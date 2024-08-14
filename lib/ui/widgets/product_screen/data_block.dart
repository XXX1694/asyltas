import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/models/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DataBlock extends StatelessWidget {
  const DataBlock({
    super.key,
    required this.product,
    required this.toLogin,
    required this.toHome,
  });
  final ProductModel product;
  final Function toLogin;
  final Function toHome;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '%МАТЕРИАЛ%',
            style: GoogleFonts.montserrat(
              color: const Color(0xFF666666),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name ?? '',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${product.price} ₸ ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                TextSpan(
                  text: '${product.price! + 300} ₸ ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 24,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              SvgPicture.asset(
                'assets/eye.svg',
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 10),
              Text(
                '24 человек смотрят сейчас',
                style: GoogleFonts.montserrat(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Только ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: product.numberLeft.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' шт осталось',
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              final token = await getSavedToken();
              if (token != null) {
                final res = await addToNewOrderField(
                  token,
                  [
                    product.toJson(),
                  ],
                );
                if (res) {
                  // await addDataToOrdersCollection(
                  //   [
                  //     {
                  //       'user': token,
                  //       'count': 1,
                  //       'product': product.toJson(),
                  //     },
                  //   ],
                  // );
                  toHome();
                }
              } else {
                toLogin();
              }
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'В корзину',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
