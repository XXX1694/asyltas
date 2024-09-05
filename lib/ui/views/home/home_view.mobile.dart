import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/home_screen/corusel.dart';
import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:asyltas/ui/widgets/home_screen/mini_catalog_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: 31,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.goToMainPage();
                            },
                            child: const Text(
                              'ASYLTAS',
                              style: TextStyle(
                                color: newBlack,
                                fontSize: 17,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              viewModel.goFavoritesPage();
                            },
                            child: SizedBox(
                              width: 31,
                              height: 31,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: SvgPicture.asset(
                                      'assets/menu_like.svg',
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
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              color: newMainColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Text(
                                                favorites.items.length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: newWhite,
                                                  fontSize: 11,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0,
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
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              viewModel.goToMenu();
                            },
                            child: SvgPicture.asset('assets/menu.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CustomCarousel(),
                  const SizedBox(height: 20),
                  MiniCatalogMobile(
                    showProduct: viewModel.goToProductPage,
                    goHome: viewModel.goToMainPage,
                    goLogin: viewModel.goToLoginPage,
                    goCatalog: viewModel.goToCatalogPage,
                  ),
                  const SizedBox(height: 16),
                  const HomeBottom(),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.black12,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  const Text(
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 24, bottom: 28),
                child: GestureDetector(
                  onTap: () {
                    viewModel.goToCartPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    width: 52,
                    height: 52,
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 31,
                      height: 31,
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
                                      color: newMainColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        cart.items.length.toString(),
                                        style: const TextStyle(
                                          color: newWhite,
                                          fontSize: 11,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
