import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/common/placeholder.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:asyltas/ui/widgets/product_screen/other_products.dart';
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
                            height: 28,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          const SizedBox(width: 12)
                        ],
                      ),
                    ),
                  ],
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
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 14,
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
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                viewModel.product.images?[currentImage] ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const ShrimerPlaceholder(
                                      height: double.infinity,
                                      width: double.infinity,
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
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
                              itemCount: viewModel.product.images?.length ?? 0,
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
                                      borderRadius: BorderRadius.circular(4),
                                      child: AppImage(
                                        imageUrl:
                                            viewModel.product.images?[index] ??
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
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Неизвестно / Неизвестно',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 16,
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
                            fontFamily: 'Montserrat',
                            color: kcPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'В пачке: ${viewModel.product.numberLeft} шт',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () async {
                        viewModel.product.count = 1;
                        final token = await getSavedToken();
                        if (token != null) {
                          final res = await addToNewOrderField(
                            token,
                            [viewModel.product.toJson()],
                          );
                          if (res) {
                            viewModel.goToCartPage();
                          }
                        } else {
                          viewModel.goToLoginPage();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: kcPrimaryColor,
                            )),
                        child: const Center(
                          child: Text(
                            'В корзину',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: kcPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Описание',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.product.description ?? '',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
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
      ),
    );
  }
}
