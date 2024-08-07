import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'product_viewmodel.dart';

class ProductViewMobile extends ViewModelWidget<ProductViewmodel> {
  const ProductViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProductViewmodel viewModel) {
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
