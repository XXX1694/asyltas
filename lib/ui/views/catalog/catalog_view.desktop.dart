import 'package:asyltas/ui/widgets/catalog_screen/catalog.dart';
import 'package:asyltas/ui/widgets/catalog_screen/top_text.dart';
import 'package:asyltas/ui/widgets/home_screen/banner.dart';
import 'package:asyltas/ui/widgets/home_screen/features.dart';
import 'package:asyltas/ui/widgets/home_screen/footer.dart';
import 'package:asyltas/ui/widgets/home_screen/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'catalog_viewmodel.dart';

class CatalogViewDesktop extends ViewModelWidget<CatalogViewmodel> {
  const CatalogViewDesktop({super.key});

  @override
  Widget build(BuildContext context, CatalogViewmodel viewModel) {
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
              const SizedBox(
                height: 70,
              ),
              const CatalogTopText(),
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 140 * deviceWidth / 2200,
                ),
                child: Catalog(
                  showProduct: viewModel.goToProductPage,
                ),
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
