import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef FutureCallbackFunction = Future Function({
  required ProductModel product,
});

class CatalogMobile extends StatefulWidget {
  const CatalogMobile({
    super.key,
    required this.showProduct,
    required this.categoryId,
    required this.goHome,
    required this.goLogin,
  });
  final FutureCallbackFunction showProduct;
  final String categoryId;
  final Function goLogin;
  final Function goHome;
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Представлено 0 товаров',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 28),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 245,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Товар',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: kcBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.41,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Категория',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: kcBlack.withOpacity(0.54),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.41,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '999 ₸',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: kcPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.41,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () async {
                                        categoryProducts[index].count = 1;
                                        final token = await getSavedToken();
                                        if (token != null) {
                                          final res = await addToNewOrderField(
                                            token,
                                            [categoryProducts[index].toJson()],
                                          );
                                          if (res) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.white,
                                                content: Text(
                                                  'Товар добавлен в корзину',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            widget.goLogin();
                                          }
                                        } else {
                                          widget.goLogin();
                                        }
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: kcPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          // border: Border.all(
                                          //   color: kcPrimaryColor,
                                          // ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'В корзину',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.41,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
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
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                mainAxisExtent: 245,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        widget.showProduct(product: categoryProducts[index]);
                      },
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AppImage(
                              imageUrl:
                                  categoryProducts[index].images?[0] ?? '',
                            ),
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
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: kcBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.41,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            categoryProducts[index].name ?? '',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kcBlack.withOpacity(0.54),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.41,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${categoryProducts[index].price ?? ''} ₸",
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: kcPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.41,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () async {
                                      categoryProducts[index].count = 1;
                                      final token = await getSavedToken();
                                      if (token != null) {
                                        final res = await addToNewOrderField(
                                          token,
                                          [categoryProducts[index].toJson()],
                                        );
                                        if (res) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Text(
                                                'Товар добавлен в корзину',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  letterSpacing: -0.41,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          widget.goLogin();
                                        }
                                      } else {
                                        widget.goLogin();
                                      }
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: kcPrimaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(
                                        //   color: kcPrimaryColor,
                                        // ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'В корзину',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
