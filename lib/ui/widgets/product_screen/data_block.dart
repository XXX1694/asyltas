import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/models/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          const Text(
            '%МАТЕРИАЛ%',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Color(0xFF666666),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name ?? '',
            style: const TextStyle(
              fontFamily: 'Montserrat',
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
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                TextSpan(
                  text: '${product.price! + 300} ₸ ',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
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
              const Text(
                '24 человек смотрят сейчас',
                style: TextStyle(
                  fontFamily: 'Montserrat',
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
                const TextSpan(
                  text: 'Только ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: product.numberLeft.toString(),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: ' шт в пачке',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
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
              product.count = 1;
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
              child: const Center(
                child: Text(
                  'В корзину',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
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
