import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class AdBanner extends StatelessWidget {
  const AdBanner({super.key, required this.showProduct});
  final FutureCallbackFunction showProduct;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/slider.svg',
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 140 * deviceWidth / 2200,
            ),
            child: Row(children: [
              const Spacer(flex: 3),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 60),
                    Text(
                      'Хрусталь',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const Spacer(flex: 24),
                    Text(
                      'Хрусталь 8мм',
                      style: GoogleFonts.montserrat(
                        fontSize: 42,
                        color: kcPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(flex: 24),
                    Text(
                      'Описание',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const Spacer(flex: 24),
                    Text(
                      'Хрустальные бусины 8 мм от бренда ASYL TAS – это идеальный выбор для любителей рукоделия и создания уникальных украшений. Каждая бусина изготовлена из высококачественного хрусталя, что обеспечивает их блеск и прозрачность. Размер бусин составляет 8 мм, длина нитки 45 см, в одной нитке 60-65 шт. Это все делает их универсальными для различных видов работ: от браслетов до ожерелий. Благодаря своей прочности и изяществу, эти бусины станут отличным дополнением к любому проекту. Используйте их для создания элегантных и изысканных украшений, которые будут отражать ваш стиль и вкус.',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                      maxLines: 4,
                    ),
                    const Spacer(flex: 36),
                    SizedBox(
                      height: 26,
                      child: Row(
                        children: [
                          Text(
                            'Размер: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            width: 58,
                            height: 25,
                            decoration: BoxDecoration(
                              color: kcPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '8мм',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(flex: 24),
                    Text(
                      '1400 ₸',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: kcPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(flex: 20),
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        showProduct(
                          product: ProductModel(
                            '02l2xpTsC00BgmMZD1CT',
                            'Хрустал 8мм',
                            [
                              'https://firebasestorage.googleapis.com/v0/b/asyltas-2c153.appspot.com/o/product_photo%2F2024-07-20T10:52:00.7785182024-07-20%2010:51:44.059217..jpg?alt=media&token=36bca7dd-223d-4633-bcaf-b89426f69c84',
                            ],
                            '0001',
                            'Хрустал 8мм',
                            'Хрустальные бусины 8 мм от бренда ASYL TAS – это идеальный выбор для любителей рукоделия и создания уникальных украшений. Каждая бусина изготовлена из высококачественного хрусталя, что обеспечивает их блеск и прозрачность. Размер бусин составляет 8 мм, длина нитки 45 см, в одной нитке 60-65 шт. Это все делает их универсальными для различных видов работ: от браслетов до ожерелий. Благодаря своей прочности и изяществу, эти бусины станут отличным дополнением к любому проекту. Используйте их для создания элегантных и изысканных украшений, которые будут отражать ваш стиль и вкус.',
                            10,
                            1400,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kcPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 52,
                        width: 190,
                        child: Center(
                          child: Text(
                            'Купить сейчас',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 60),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
