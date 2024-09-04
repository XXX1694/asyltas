import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/catalog_screen/catalog_mobile.dart';
import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'category_viewmodel.dart';

class CategoryViewMobile extends ViewModelWidget<CategoryViewModel> {
  const CategoryViewMobile({super.key});

  @override
  Widget build(BuildContext context, CategoryViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            viewModel.goToMainPage();
                          },
                          child: SvgPicture.asset(
                            'assets/logo.svg',
                            height: 34,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              viewModel.goToFavoritesPage();
                            },
                            child: SizedBox(
                              width: 42,
                              height: 40,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        color: kcPrimaryColor.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/like.svg',
                                      ),
                                    ),
                                  ),
                                  context
                                          .read<FavoritesProvider>()
                                          .items
                                          .isNotEmpty
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: kcPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Text(
                                                context
                                                    .read<FavoritesProvider>()
                                                    .items
                                                    .length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              viewModel.goToCartPage();
                            },
                            child: SizedBox(
                              width: 42,
                              height: 40,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/cart1.svg',
                                    ),
                                  ),
                                  context.read<CartProvider>().items.isNotEmpty
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: kcPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Text(
                                                context
                                                    .read<CartProvider>()
                                                    .items
                                                    .length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              viewModel.goToMenu();
                            },
                            child: SvgPicture.asset('assets/burger.svg'),
                          ),
                          const SizedBox(width: 12)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Катаегория: ${viewModel.categoryName}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: kcPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Главная / Каталог / ${viewModel.categoryName}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CatalogMobile(
                      showProduct: viewModel.goToProductPage,
                      categoryId: viewModel.categoryId,
                      goHome: viewModel.goToMainPage,
                      goLogin: viewModel.goToLoginPage,
                    ),
                    const SizedBox(height: 16),
                    const HomeBottom(),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.black12,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        '© 2024 Asyltas Разработано galab.kz',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.41,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getNewOrderFromFirestore(String docID) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(docID);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return data?['newOrder'] as List<dynamic>;
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document: $e');
      }
      return [];
    }
  }

  Future<String?> getDocIDFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('idToken'); // Replace 'docID' with your actual key
  }

  Future<List<dynamic>> _loadData() async {
    final docID = await getDocIDFromSharedPreferences();
    if (docID != null) {
      List<dynamic>? orders = await getNewOrderFromFirestore(docID);
      return orders;
    } else {
      return [];
    }
  }
}
