import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/common/placeholder.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:asyltas/ui/widgets/product_screen/cart_button.dart';
import 'package:asyltas/ui/widgets/product_screen/other_products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'product_viewmodel.dart';

class ProductViewMobile extends ViewModelWidget<ProductViewmodel> {
  const ProductViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProductViewmodel viewModel) {
    int currentImage = 0;
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              viewModel.goToFavoritesPage();
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
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Главная / Каталог / ${viewModel.product.category_name}',
                          style: TextStyle(
                            color: newBlack54,
                            fontSize: 15,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        StatefulBuilder(
                          builder: (context, setState) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: viewModel
                                            .product.images?[currentImage] ??
                                        '',
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const ShrimerPlaceholder(
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                    errorWidget: (context, url, error) {
                                      return const ShrimerPlaceholder(
                                        height: double.infinity,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 75,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      viewModel.product.images?.length ?? 0,
                                  itemBuilder: (context, index) => Container(
                                    height: 74,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        setState(() {
                                          currentImage = index;
                                        });
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: AppImage(
                                            imageUrl: viewModel
                                                    .product.images?[index] ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          viewModel.product.name ?? '',
                          style: const TextStyle(
                            color: newBlack,
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Неизвестно / Неизвестно',
                          style: TextStyle(
                            color: newBlack54,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${viewModel.product.price} ₸',
                              style: const TextStyle(
                                color: newMainColor,
                                fontSize: 20,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'В пачке: ${viewModel.product.numberLeft} шт',
                              style: const TextStyle(
                                color: newBlack,
                                fontFamily: 'Gilroy',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        CartButton(
                          viewModel: viewModel,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Описание',
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          viewModel.product.description ?? '',
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            color: newBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  OtherProducts(
                    products: viewModel.categoryProducts,
                    showProduct: viewModel.goToProductPage,
                  ),
                  const SizedBox(height: 40),
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
