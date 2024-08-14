import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class Catalog extends StatefulWidget {
  const Catalog({super.key, required this.showProduct});
  final FutureCallbackFunction showProduct;
  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Map<String, String>> category = [
    {
      'id': '0001',
      'name': 'Хрустал 8мм',
    },
    {
      'id': '0002',
      'name': 'Хрустал 6мм',
    },
    {
      'id': '0003',
      'name': 'Хрустал 4мм',
    },
    {
      'id': '0004',
      'name': 'Хрустал 4мм биконус',
    },
    {
      'id': '0005',
      'name': 'Хрустал 2мм',
    },
    {
      'id': '0006',
      'name': 'Хрустал 0.8мм',
    },
    {
      'id': '0007',
      'name': 'Хрустал алмаз 4мм',
    },
    {
      'id': '0008',
      'name': 'Хрустал капля 8/12мм',
    },
    {
      'id': '0009',
      'name': 'Хрустал 6/8мм',
    },
    {
      'id': '0010',
      'name': 'Поджемчук',
    },
    {
      'id': '0011',
      'name': 'Шашбау',
    },
    {
      'id': '0012',
      'name': 'Основа',
    },
    {
      'id': '0013',
      'name': 'Страз лента',
    },
    {
      'id': '0014',
      'name': 'Страз на листь',
    },
    {
      'id': '0015',
      'name': 'Перья',
    },
    {
      'id': '0016',
      'name': 'Расходной материал',
    },
    {
      'id': '0017',
      'name': 'Стразы капля 6х10',
    },
    {
      'id': '0018',
      'name': 'Стразы капля 8х13',
    },
    {
      'id': '0019',
      'name': 'Стразы капля 10х14',
    },
    {
      'id': '0020',
      'name': 'Стразы капля 13х18',
    },
  ];
  int selescted = 0;
  List products = [];
  List<ProductModel> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Категория',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: category.length,
                  itemBuilder: (context, index) => CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        categoryProducts = [];
                        for (int i = 0; i < products.length; i++) {
                          final product =
                              products[i].data() as Map<String, dynamic>;
                          String productCategoryId =
                              (product['category_id'] ?? '').toString();
                          String selectedCategoryId =
                              (category[index]['id'] ?? '').toString();

                          if (productCategoryId == selectedCategoryId) {
                            categoryProducts
                                .add(ProductModel.fromJson(product));
                            categoryProducts.last.id = products[i].id;
                          }
                        }
                        selescted = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        category[index]['name']!,
                        style: GoogleFonts.montserrat(
                          color: selescted == index
                              ? const Color(0xFF4F6D9F)
                              : Colors.black54,
                          fontSize: 18,
                          decoration: selescted == index
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: const Color(0xFF4F6D9F),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 100),
        Expanded(
          flex: 20,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 302 / 348,
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 40),
                            color: kcBlack.withOpacity(0.06),
                            blurRadius: 90,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(''),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 302 / 348,
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 40),
                            color: kcBlack.withOpacity(0.06),
                            blurRadius: 90,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(''),
                    );
                  },
                );
                // return Center(
                //     child: Text('Something went wrong! ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              products = snapshot.data!.docs;
              categoryProducts = [];
              for (int i = 0; i < products.length; i++) {
                final product = products[i].data() as Map<String, dynamic>;
                String productCategoryId =
                    (product['category_id'] ?? '').toString();
                String selectedCategoryId =
                    (category[selescted]['id'] ?? '').toString();

                if (productCategoryId == selectedCategoryId) {
                  categoryProducts.add(ProductModel.fromJson(product));
                  categoryProducts.last.id = products[i].id;
                }
              }
              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 386 / 438,
                  crossAxisCount: 3,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  // mainAxisExtent: 438,
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      widget.showProduct(product: categoryProducts[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 40),
                            color: kcBlack.withOpacity(0.06),
                            blurRadius: 90,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: categoryProducts[index].images != null
                                    ? AppImage(
                                        imageUrl: categoryProducts[index]
                                                .images?[0] ??
                                            '',
                                      )
                                    : Container(
                                        color: Colors.grey.shade400,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  categoryProducts[index].name ?? '',
                                  style: GoogleFonts.montserrat(
                                    color: kcBlack,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${categoryProducts[index].price ?? ''} ₸",
                                      style: GoogleFonts.poppins(
                                        color: kcPrimaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Осталось: ${categoryProducts[index].numberLeft ?? ''}",
                                      style: GoogleFonts.poppins(
                                        color: kcBlack,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
