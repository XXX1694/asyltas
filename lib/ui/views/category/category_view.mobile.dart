import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/catalog_screen/catalog_mobile.dart';
import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'category_viewmodel.dart';

class CategoryViewMobile extends ViewModelWidget<CategoryViewModel> {
  const CategoryViewMobile({super.key});

  @override
  Widget build(BuildContext context, CategoryViewModel viewModel) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 27),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
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
                                          color:
                                              kcPrimaryColor.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/like.svg',
                                        ),
                                      ),
                                    ),
                                    Consumer<FavoritesProvider>(
                                      builder: (context, favorites, child) {
                                        if (favorites.items.isEmpty) {
                                          return const SizedBox();
                                        } else {
                                          return Align(
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
                                                  favorites.items.length
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
                                          );
                                        }
                                      },
                                    )
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
                                    Consumer<CartProvider>(
                                      builder: (context, cart, child) {
                                        if (cart.items.isEmpty) {
                                          return const SizedBox();
                                        } else {
                                          return Align(
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
                                                  cart.items.length.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Главная / Каталог / ${viewModel.categoryName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: newBlack54,
                        fontFamily: 'Gilroy',
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
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
}
