import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/catalog_screen/catalog_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'category_viewmodel.dart';

class CategoryViewMobile extends ViewModelWidget<CategoryViewModel> {
  const CategoryViewMobile({super.key});

  @override
  Widget build(BuildContext context, CategoryViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          viewModel.goToMenu();
                        },
                        child: SvgPicture.asset('assets/burger.svg'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Катаегория: ${viewModel.categoryName}',
                      style: GoogleFonts.montserrat(
                        color: kcPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Главная / Каталог / ${viewModel.categoryName}',
                      style: GoogleFonts.montserrat(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CatalogMobile(
                      showProduct: viewModel.goToProductPage,
                      categoryId: viewModel.categoryId,
                      goHome: viewModel.goToMainPage,
                      goLogin: viewModel.goToLoginPage,
                    )
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
