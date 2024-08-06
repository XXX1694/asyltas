import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniCatalog extends StatefulWidget {
  const MiniCatalog({super.key});

  @override
  State<MiniCatalog> createState() => _MiniCatalogState();
}

class _MiniCatalogState extends State<MiniCatalog> {
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
      'id': '0005',
      'name': 'Хрустал 2мм',
    },
    {
      'id': '0007',
      'name': 'Хрустал алмаз 4мм',
    },
  ];
  int selescted = 1;
  List products = [];
  List<ProductModel> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 160),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                categoryItem(0),
                categoryItem(1),
                categoryItem(2),
                categoryItem(3),
                categoryItem(4),
              ],
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 1434,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 386 / 438,
                        crossAxisCount: 3,
                        crossAxisSpacing: 60,
                        mainAxisSpacing: 60,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 15,
                            bottom: 36,
                          ),
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
                          child: Text(''),
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
                  for (int i = 0; i < products.length; i++) {
                    final product = products[i].data() as Map<String, dynamic>;
                    String productCategoryId =
                        (product['category_id'] ?? '').toString();
                    String selectedCategoryId =
                        (category[selescted]['id'] ?? '').toString();

                    if (productCategoryId == selectedCategoryId) {
                      categoryProducts.add(ProductModel.fromJson(product));
                    }
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 386 / 438,
                      crossAxisCount: 3,
                      crossAxisSpacing: 60,
                      mainAxisSpacing: 60,
                    ),
                    itemCount: categoryProducts.length > 9
                        ? 9
                        : categoryProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 15,
                          bottom: 36,
                        ),
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
                        child: Text(categoryProducts[index].name ?? ''),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget categoryItem(int index) {
    return GestureDetector(
      onTap: () {
        for (int i = 0; i < products.length; i++) {
          final product = products[i].data() as Map<String, dynamic>;
          String productCategoryId = (product['category_id'] ?? '').toString();
          String selectedCategoryId = (category[index]['id'] ?? '').toString();

          if (productCategoryId == selectedCategoryId) {
            categoryProducts.add(ProductModel.fromJson(product));
          }
        }
        setState(() {
          selescted = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: selescted == index ? kcPrimaryColor : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
          boxShadow: selescted == index
              ? [
                  BoxShadow(
                    offset: const Offset(0, 20),
                    color: kcBlack.withOpacity(0.15),
                    blurRadius: 15,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            category[index]['name'] ?? '',
            style: GoogleFonts.montserrat(
              color: selescted == index ? kcWhite : kcLightGrey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
