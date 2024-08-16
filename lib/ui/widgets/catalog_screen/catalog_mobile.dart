import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class CatalogMobile extends StatefulWidget {
  const CatalogMobile({
    super.key,
    required this.showProduct,
    required this.categoryId,
  });
  final FutureCallbackFunction showProduct;
  final String categoryId;
  @override
  State<CatalogMobile> createState() => _CatalogMobileState();
}

class _CatalogMobileState extends State<CatalogMobile> {
  List products = [];
  List<ProductModel> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No products available.'));
        }
        products = snapshot.data!.docs;
        categoryProducts = [];
        for (int i = 0; i < products.length; i++) {
          final product = products[i].data() as Map<String, dynamic>;
          String productCategoryId = (product['category_id'] ?? '').toString();

          if (productCategoryId == widget.categoryId) {
            categoryProducts.add(ProductModel.fromJson(product));
            categoryProducts.last.id = products[i].id;
          }
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Представлено ${categoryProducts.length} товаров',
              style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 162 / 245,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                // mainAxisExtent: 438,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                return CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    widget.showProduct(product: categoryProducts[index]);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: AppImage(
                              imageUrl:
                                  categoryProducts[index].images?[0] ?? '',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryProducts[index].name ?? '',
                              style: GoogleFonts.montserrat(
                                color: kcBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              categoryProducts[index].name ?? '',
                              style: GoogleFonts.montserrat(
                                color: kcBlack.withOpacity(0.54),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${categoryProducts[index].price ?? ''} ₸",
                                  style: GoogleFonts.poppins(
                                    color: kcPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Осталось: ${categoryProducts[index].numberLeft ?? ''} ",
                                  style: GoogleFonts.poppins(
                                    color: kcBlack,
                                    fontSize: 12,
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
                );
              },
            ),
          ],
        );
      },
    );
  }
}
