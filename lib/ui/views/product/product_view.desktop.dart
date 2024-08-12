import 'package:asyltas/ui/widgets/home_screen/banner.dart';
import 'package:asyltas/ui/widgets/home_screen/features.dart';
import 'package:asyltas/ui/widgets/home_screen/footer.dart';
import 'package:asyltas/ui/widgets/home_screen/top_bar.dart';
import 'package:asyltas/ui/widgets/product_screen/data_block.dart';
import 'package:asyltas/ui/widgets/product_screen/image_block.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'product_viewmodel.dart';

class ProductViewDesktop extends ViewModelWidget<ProductViewmodel> {
  const ProductViewDesktop({super.key});

  @override
  Widget build(BuildContext context, ProductViewmodel viewModel) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 140 * deviceWidth / 2200,
                ),
                child: TopBar(
                  toLoginPage: () {
                    viewModel.goToLoginPage();
                  },
                  toCatalogPage: () {
                    viewModel.goToCatalogPage();
                  },
                  toMainPage: () {
                    viewModel.goToMainPage();
                  },
                  toRegistrationPage: () {
                    viewModel.goToRegistrationPage();
                  },
                  toSalesPage: () {},
                  toCartPage: () {
                    viewModel.goToCartPage();
                  },
                  toProfilePage: () {
                    viewModel.goToProfilePage();
                  },
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ImageBlock(
                      product: viewModel.product,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DataBlock(
                      product: viewModel.product,
                      toLogin: viewModel.goToLoginPage,
                      toHome: viewModel.goToMainPage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              AdBanner(
                showProduct: viewModel.goToProductPage,
              ),
              const FeaturesBlock(),
              const SizedBox(height: 100),
              const Divider(
                height: 1,
                color: Color(0xFFDEDFE1),
              ),
              const CustomFooter(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
