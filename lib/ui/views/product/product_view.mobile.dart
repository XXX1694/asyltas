import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:asyltas/ui/widgets/product_screen/other_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'product_viewmodel.dart';

class ProductViewMobile extends ViewModelWidget<ProductViewmodel> {
  const ProductViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProductViewmodel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/logo_small.png'),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          const Spacer(),
                          CupertinoButton(
                            padding: const EdgeInsets.only(right: 20),
                            onPressed: () {
                              viewModel.goToCartPage();
                            },
                            child: SvgPicture.asset('assets/cart.svg'),
                          ),
                          // const SizedBox(width: 12),
                          CupertinoButton(
                            padding: const EdgeInsets.only(right: 20),
                            onPressed: () {
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
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: AppImage(
                          imageUrl: viewModel.product.images?[0] ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.product.images?.length ?? 0,
                        itemBuilder: (context, index) => AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: AppImage(
                              imageUrl: viewModel.product.images?[index] ?? '',
                            ),
                          ),
                        ),
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
                    Text(
                      '${viewModel.product.price} ₸',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: kcPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
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
