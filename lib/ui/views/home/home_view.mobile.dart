import 'package:asyltas/ui/widgets/home_screen/mini_catalog_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewMobile extends ViewModelWidget<HomeViewModel> {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                      child: CupertinoButton(
                        padding: const EdgeInsets.only(right: 20),
                        onPressed: () {
                          viewModel.goToMenu();
                        },
                        child: SvgPicture.asset('assets/burger.svg'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MiniCatalogMobile(
                showProduct: viewModel.goToProductPage,
                goHome: viewModel.goToMainPage,
                goLogin: viewModel.goToLoginPage,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
