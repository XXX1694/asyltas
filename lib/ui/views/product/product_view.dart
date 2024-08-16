import 'package:asyltas/models/product.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'product_view.desktop.dart';
import 'product_viewmodel.dart';

class ProductView extends StackedView<ProductViewmodel> {
  final ProductModel product;
  const ProductView({
    super.key,
    required this.product,
  });

  @override
  Widget builder(
    BuildContext context,
    ProductViewmodel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const ProductViewDesktop(),
      tablet: (_) => const ProductViewDesktop(),
      desktop: (_) => const ProductViewDesktop(),
    );
  }

  @override
  ProductViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductViewmodel(product: product);
}
