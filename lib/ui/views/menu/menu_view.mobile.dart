import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'menu_viewmodel.dart';

class MenuViewMobile extends ViewModelWidget<MenuViewmodel> {
  const MenuViewMobile({super.key});

  @override
  Widget build(BuildContext context, MenuViewmodel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        viewModel.goBack();
                      },
                      child: SvgPicture.asset('assets/close.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Меню',
                      style: GoogleFonts.montserrat(
                        color: kcPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        viewModel.goToMainPage();
                      },
                      child: Text(
                        'Главная',
                        style: GoogleFonts.montserrat(
                          color: kcPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // CupertinoButton(
                    //   padding: const EdgeInsets.all(0),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Поиск',
                    //     style: GoogleFonts.montserrat(
                    //       color: kcPrimaryColor,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        viewModel.goToCatalogPage();
                      },
                      child: Text(
                        'Каталог',
                        style: GoogleFonts.montserrat(
                          color: kcPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // CupertinoButton(
                    //   padding: const EdgeInsets.all(0),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Скидки',
                    //     style: GoogleFonts.montserrat(
                    //       color: kcPrimaryColor,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        bool res = await checkAuth();
                        if (res) {
                          viewModel.goToCartPage();
                        } else {
                          viewModel.goToLoginPage();
                        }
                      },
                      child: Text(
                        'Корзина',
                        style: GoogleFonts.montserrat(
                          color: kcPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        bool res = await checkAuth();
                        if (res) {
                          viewModel.goToProfilePage();
                        } else {
                          viewModel.goToLoginPage();
                        }
                      },
                      child: Text(
                        'Профиль',
                        style: GoogleFonts.montserrat(
                          color: kcPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: checkAuth(),
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return GestureDetector(
                            onTap: () async {
                              await deleteToken();
                              viewModel.goToMainPage();
                            },
                            child: Text(
                              'Выйти',
                              style: GoogleFonts.montserrat(
                                color: Colors.red.shade400,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    // const SizedBox(height: 12),
                    // CupertinoButton(
                    //   padding: const EdgeInsets.all(0),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Контакты',
                    //     style: GoogleFonts.montserrat(
                    //       color: kcPrimaryColor,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
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
