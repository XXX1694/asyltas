import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartViewMobile extends ViewModelWidget<CartViewModel> {
  const CartViewMobile({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(),
        ),
      ),
    );
  }
}
