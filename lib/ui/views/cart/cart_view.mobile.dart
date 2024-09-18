import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/cart_screen/cart_mobile_new.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartViewMobile extends ViewModelWidget<CartViewModel> {
  const CartViewMobile({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return Scaffold(
      backgroundColor: newWhite,
      body: CartMobileNew(
        goToFavoritesPage: viewModel.goFavoritesPage,
        goToMenu: viewModel.goToMenu,
        showPayment: viewModel.goToPaymentPage,
        goToMainPage: viewModel.goToMainPage,
      ),
    );
  }
}
