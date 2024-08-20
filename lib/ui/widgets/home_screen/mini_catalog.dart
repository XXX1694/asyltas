import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class MiniCatalog extends StatefulWidget {
  const MiniCatalog({
    super.key,
    required this.showProduct,
    required this.goHome,
    required this.goLogin,
  });
  final FutureCallbackFunction showProduct;
  final Function goLogin;
  final Function goHome;
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              categoryItem(0),
              const SizedBox(width: 40),
              categoryItem(1),
              const SizedBox(width: 40),
              categoryItem(2),
              const SizedBox(width: 40),
              categoryItem(3),
              const SizedBox(width: 40),
              categoryItem(4),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Flexible(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GridView.builder(
                    shrinkWrap: true,
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
                        constraints: const BoxConstraints(maxHeight: 438),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 20),
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
                        constraints: const BoxConstraints(maxHeight: 438),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // boxShadow: [
                          //   BoxShadow(
                          //     offset: const Offset(0, 40),
                          //     color: kcBlack.withOpacity(0.06),
                          //     blurRadius: 90,
                          //   )
                          // ],
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
                    categoryProducts.last.id = snapshot.data!.docs[i].id;
                  }
                }
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 386 / 438,
                    crossAxisCount: 3,
                    crossAxisSpacing: 60,
                    mainAxisSpacing: 60,
                    // mainAxisExtent: 438,
                  ),
                  itemCount:
                      categoryProducts.length > 9 ? 9 : categoryProducts.length,
                  itemBuilder: (context, index) {
                    return CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        widget.showProduct(product: categoryProducts[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 20),
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
                              aspectRatio: 336 / 244,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AppImage(
                                    imageUrl:
                                        categoryProducts[index].images?[0] ??
                                            '',
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
                                  const SizedBox(height: 2),
                                  Text(
                                    categoryProducts[index].name ?? '',
                                    style: GoogleFonts.montserrat(
                                      color: kcBlack.withOpacity(0.54),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Цвет: Неизвестно',
                                        style: GoogleFonts.montserrat(
                                          color: kcPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
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
                                        const SizedBox(width: 40),
                                        GestureDetector(
                                          onTap: () async {
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
                                                widget.goHome;
                                              } else {
                                                widget.goLogin;
                                              }
                                            } else {
                                              widget.goLogin;
                                            }
                                          },
                                          child: Container(
                                            height: 38,
                                            width: 132,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: kcPrimaryColor,
                                                )),
                                            child: Center(
                                              child: Text(
                                                'В корзину',
                                                style: GoogleFonts.montserrat(
                                                  color: kcPrimaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
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
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

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
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: selescted == index ? kcPrimaryColor : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
          boxShadow: selescted == index
              ? [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    color: kcBlack.withOpacity(0.05),
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
