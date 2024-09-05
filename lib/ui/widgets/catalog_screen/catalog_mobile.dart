import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/widgets/catalog_screen/catalog_placegolder.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

typedef FutureCallbackFunction = Future Function({
  required ProductModel product,
  required List<ProductModel> categoryProducts,
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
              Text(
                'Представлено 0 товаров',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: newBlack54,
                  fontFamily: 'Gilroy',
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 28),
              const CatalogPlacegolder(),
            ],
          );
        }
        if (snapshot.hasError) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Представлено 0 товаров',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 28),
              CatalogPlacegolder(),
            ],
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Представлено 0 товаров',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 28),
              CatalogPlacegolder(),
            ],
          );
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
                childAspectRatio: 160 / 240,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                // mainAxisExtent: 290,
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
                        widget.showProduct(
                          product: categoryProducts[index],
                          categoryProducts: categoryProducts,
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.network(
                                categoryProducts[index].images?[0] ?? '',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            categoryProducts[index].name ?? '',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: kcBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.41,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${categoryProducts[index].price},00 ₸",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: kcPrimaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.41,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${int.parse(categoryProducts[index].price.toString()) + 200},00 ₸",
                                style: const TextStyle(
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
                                  onPressed: () async {
                                    categoryProducts[index].count = 1;
                                    context.read<FavoritesProvider>().addItem(
                                          categoryProducts[index],
                                        );
                                    _showTimedAlertDialog2(context);
                                  },
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () async {
                                      categoryProducts[index].count = 1;
                                      context.read<CartProvider>().addItem(
                                            categoryProducts[index],
                                          );
                                      _showTimedAlertDialog(context);
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        // color: kcPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.black,
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
            ),
          ],
        );
      },
    );
  }

  void _showTimedAlertDialog(BuildContext context) {
    // Show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          iconPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),

          title: const Center(
            child: Text(
              'Добавлен в корзину!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // content: const Text('Добавлен в корзину'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        );
      },
    );
  }

  void _showTimedAlertDialog2(BuildContext context) {
    // Show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          iconPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),

          title: const Center(
            child: Text(
              'Добавлен в избранные!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // content: const Text('Добавлен в корзину'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        );
      },
    );
  }
}
