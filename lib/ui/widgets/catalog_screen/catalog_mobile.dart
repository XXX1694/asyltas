import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/ui/widgets/catalog_screen/catalog_placegolder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class _CatalogMobileState extends State<CatalogMobile>
    with TickerProviderStateMixin {
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
            StaggeredGrid.count(
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              children: categoryProducts.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        widget.showProduct(
                          product: item,
                          categoryProducts: categoryProducts,
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: item.images?[0] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.name ?? '',
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${item.price},00 ₸",
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            widget.showProduct(
                              product: item,
                              categoryProducts: categoryProducts,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: newBlack,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(5, 5),
                                  blurRadius: 15,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            height: 32,
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                'Подробнее',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            item.count = 1;
                            context.read<CartProvider>().addItem(
                                  item,
                                );

                            showCustomSnackBar(context, 'Добавлен в корзину!');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: newBlack,
                                width: 1,
                              ),
                            ),
                            height: 32,
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                'В корзину',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        bottom: MediaQuery.of(context).size.height * 0.12,
        child: SlideTransition(
          position: _slideAnimation(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: newBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: newWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 1500), () {
      overlayEntry.remove();
    });
  }

  Animation<Offset> _slideAnimation() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
    return animation;
  }
}
