import 'package:asyltas/ui/widgets/home_screen/banner.dart';
import 'package:asyltas/ui/widgets/home_screen/features.dart';
import 'package:asyltas/ui/widgets/home_screen/footer.dart';
import 'package:asyltas/ui/widgets/home_screen/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'payment_viewmodel.dart';

class PaymentViewDesktop extends ViewModelWidget<PaymentViewModel> {
  const PaymentViewDesktop({super.key});

  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
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
              const SizedBox(height: 70),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'К оплате: ${viewModel.price}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 42,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Оплатите полную сумму через каспи и отправьте чек на ватсап',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 140 * deviceWidth / 2200,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/kaspi.png',
                        height: deviceWidth * 0.3,
                      ),
                      Image.asset(
                        'assets/whatsapp.png',
                        height: deviceWidth * 0.3,
                      ),
                    ],
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
