import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/home_screen/banner.dart';
import 'package:asyltas/ui/widgets/home_screen/features.dart';
import 'package:asyltas/ui/widgets/home_screen/footer.dart';
import 'package:asyltas/ui/widgets/home_screen/top_bar.dart';
import 'package:asyltas/ui/widgets/home_screen/top_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileViewDesktop extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewDesktop({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
              const SizedBox(height: 100),
              const TopText(),
              const SizedBox(height: 50),
              const SizedBox(height: 50),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  viewModel.goToCatalogPage();
                },
                child: Container(
                  height: 56,
                  width: 207,
                  decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        color: kcBlack.withOpacity(0.05),
                        blurRadius: 35,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Показать все',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
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
