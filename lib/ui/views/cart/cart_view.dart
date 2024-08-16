import 'package:asyltas/ui/views/cart/cart_view.mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'cart_view.desktop.dart';
import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const CartViewMobile(),
      tablet: (_) => const CartViewDesktop(),
      desktop: (_) => const CartViewDesktop(),
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel();
}
