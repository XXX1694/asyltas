import 'package:asyltas/models/product.dart';
import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:asyltas/ui/widgets/home_screen/mini_catalog_placegolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

typedef FutureCallbackFunction = Future Function({
  required ProductModel product,
  required List<ProductModel> categoryProducts,
});

class MiniCatalogMobile extends StatefulWidget {
  const MiniCatalogMobile({
    super.key,
    required this.showProduct,
    required this.goHome,
    required this.goLogin,
    required this.goCatalog,
  });
  final FutureCallbackFunction showProduct;
  final Function goLogin;
  final Function goHome;
  final Function goCatalog;
  @override
  State<MiniCatalogMobile> createState() => _MiniCatalogMobileState();
}

class _MiniCatalogMobileState extends State<MiniCatalogMobile> {
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
    {
      'id': '0017',
      'name': "Стразы капля 6х10",
    },
    {
      'id': '0018',
      'name': "Стразы капля 8х13",
    },
    {
      'id': '0019',
      'name': "Стразы капля 10х14",
    },
  ];
  int selescted = 0;
  List products = [];
  List<ProductModel> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          height: 230,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  'КАТЕГОРИИ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: kcBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
              const Divider(
                // height: 1,
                color: Colors.black12,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 12 : 0,
                      right: 12,
                    ),
                    child: categoryItem(index),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MiniCatalogPlacegolder();
              }
              if (snapshot.hasError) {
                return const MiniCatalogPlacegolder();
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

                  categoryProducts.last.id = snapshot.data!.docs[i].id;
                }
              }

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ВСЕ ТОВАРЫ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kcBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.41,
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: SvgPicture.asset('assets/more.svg'),
                            onPressed: () {
                              widget.goCatalog();
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      // height: 1,
                      color: Colors.black12,
                    ),
                    // const SizedBox(height: 4),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 160 / 240,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        // mainAxisExtent: 290,
                      ),
                      itemCount: categoryProducts.length > 10
                          ? 10
                          : categoryProducts.length,
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
                                    child: AppImage(
                                      imageUrl:
                                          categoryProducts[index].images?[0] ??
                                              '',
                                    ),
                                  ),
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CupertinoButton(
                                            padding: const EdgeInsets.all(0),
                                            child: SvgPicture.asset(
                                              'assets/like.svg',
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              categoryProducts[index].count = 1;
                                              context
                                                  .read<FavoritesProvider>()
                                                  .addItem(
                                                    categoryProducts[index],
                                                  );
                                              _showTimedAlertDialog2(context);
                                            }),
                                        const SizedBox(height: 12),
                                        Expanded(
                                          child: CupertinoButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              categoryProducts[index].count = 1;
                                              context
                                                  .read<CartProvider>()
                                                  .addItem(
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showTimedAlertDialog(BuildContext context) {
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

  List<String> images = [
    'assets/images/8mm.jpg',
    'assets/images/6mm.jpg',
    'assets/images/4mm.jpg',
    'assets/images/2mm.jpg',
    'assets/images/4mmb.jpg',
    'assets/images/610.jpg',
    'assets/images/813.jpg',
    'assets/images/1014.jpg',
  ];
  Widget categoryItem(int index) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        setState(() {
          categoryProducts = [];
          for (int i = 0; i < products.length; i++) {
            final product = products[i].data() as Map<String, dynamic>;
            String productCategoryId =
                (product['category_id'] ?? '').toString();
            String selectedCategoryId =
                (category[index]['id'] ?? '').toString();

            if (productCategoryId == selectedCategoryId) {
              categoryProducts.add(ProductModel.fromJson(product));
              categoryProducts.last.id = products[i].id;
            }
          }
          selescted = index;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: ClipOval(
              // borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                images[index],
                height: double.infinity,
                width: 106,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category[index]['name'] ?? '',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: selescted == index ? kcPrimaryColor : Colors.black54,
              fontSize: 13,
              fontWeight:
                  selescted == index ? FontWeight.w600 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
