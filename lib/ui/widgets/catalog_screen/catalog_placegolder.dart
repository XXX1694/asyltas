import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/common/placeholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CatalogPlacegolder extends StatelessWidget {
  const CatalogPlacegolder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 160 / 240,
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        // mainAxisExtent: 255,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const ShrimerPlaceholder(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Товар',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: kcBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.41,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1000,00 ₸",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: kcPrimaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.41,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "1200,00 ₸",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.41,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: SvgPicture.asset(
                            'assets/like.svg',
                            // ignore: deprecated_member_use
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () async {},
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: kcPrimaryColor,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: kcPrimaryColor,
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/cart.svg',
                                  // ignore: deprecated_member_use
                                  color: Colors.black,
                                  height: 17,
                                  width: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
