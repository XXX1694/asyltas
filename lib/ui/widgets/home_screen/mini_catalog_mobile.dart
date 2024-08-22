import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class MiniCatalogMobile extends StatefulWidget {
  const MiniCatalogMobile({
    super.key,
    required this.showProduct,
    required this.goHome,
    required this.goLogin,
  });
  final FutureCallbackFunction showProduct;
  final Function goLogin;
  final Function goHome;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 178,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: categoryItem(0)),
                      Expanded(child: categoryItem(1)),
                      Expanded(child: categoryItem(2)),
                      Expanded(child: categoryItem(3)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: categoryItem(4)),
                    Expanded(child: categoryItem(5)),
                    Expanded(child: categoryItem(6)),
                    Expanded(child: categoryItem(7)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 255,
                      ),
                      itemCount: 10,
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
                                );
                              },
                              child: AspectRatio(
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
                                              final token =
                                                  await getSavedToken();
                                              if (token != null) {
                                                final res =
                                                    await addToNewOrderField(
                                                  token,
                                                  [
                                                    categoryProducts[index]
                                                        .toJson()
                                                  ],
                                                );
                                                if (res) {
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      content: Text(
                                                        'Товар добавлен в корзину',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
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
                    );
                  }
                  if (snapshot.hasError) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 255,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(''),
                        );
                      },
                    );
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
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // childAspectRatio: 165 / 245,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 255,
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
                                  product: categoryProducts[index]);
                            },
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              final res =
                                                  await addToNewOrderField(
                                                token,
                                                [
                                                  categoryProducts[index]
                                                      .toJson()
                                                ],
                                              );
                                              if (res) {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: Text(
                                                      'Товар добавлен в корзину',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
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
                  );
                }),
          ),
        ],
      ),
    );
  }

  List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              images[index],
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            category[index]['name'] ?? '',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: selescted == index ? kcPrimaryColor : Colors.black54,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
