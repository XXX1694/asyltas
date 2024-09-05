import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'menu_viewmodel.dart';

class MenuViewMobile extends ViewModelWidget<MenuViewmodel> {
  const MenuViewMobile({super.key});

  @override
  Widget build(BuildContext context, MenuViewmodel viewModel) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
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
                      viewModel.goBack();
                    },
                    child: SvgPicture.asset(
                      'assets/сlose.svg',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        viewModel.goToMainPage();
                      },
                      child: const Text(
                        'Главная',
                        style: TextStyle(
                          color: newBlack,
                          fontSize: 28,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 42),
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        viewModel.goToCatalogPage();
                      },
                      child: const Text(
                        'Каталог',
                        style: TextStyle(
                          color: newBlack,
                          fontSize: 28,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        viewModel.goToCartPage();
                      },
                      child: const Text(
                        'Корзина',
                        style: TextStyle(
                          color: newBlack,
                          fontSize: 28,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () async {
                        viewModel.goToFavoritesPage();
                      },
                      child: const Text(
                        'Избранные',
                        style: TextStyle(
                          color: newBlack,
                          fontSize: 28,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
