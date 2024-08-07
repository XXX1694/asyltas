import 'package:asyltas/models/product.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FutureCallbackFunction = Future Function(
    {required ProductModel product});

class MiniCatalog extends StatefulWidget {
  const MiniCatalog({super.key, required this.showProduct});
  final FutureCallbackFunction showProduct;
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
                    return GestureDetector(
                      onTap: () {
                        widget.showProduct(product: categoryProducts[index]);
                      },
                      child: Container(
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
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: FirebaseImageProvider(
                                      FirebaseUrl(
                                        categoryProducts[index].images?[0] ??
                                            '',
                                      ),
                                      options: const CacheOptions(
                                        checkIfFileUpdatedOnServer: true,
                                        // Source from image will be fetched
                                        //
                                        // Default [Source.cacheServer]
                                        // source: Source.server,
                                      ),
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
                                      // [ImageNotFoundException] will be thrown if image does not exist on server.
                                      if (error is ImageNotFoundException) {
                                        return const Text(
                                            'Image not found on Cloud Storage.');
                                      } else {
                                        return Text(
                                            'Error loading image: $error');
                                      }
                                    },
                                    loadingBuilder: (_, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        // Show the loaded image if loading is complete.
                                        return child;
                                      } else {
                                        return Container(
                                          color: Colors.grey.shade400,
                                        );
                                      }
                                    },
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
              }),
        ),
      ],
    );
  }

  Widget categoryItem(int index) {
    return GestureDetector(
      onTap: () {
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
