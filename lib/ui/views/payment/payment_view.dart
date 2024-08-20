import 'package:asyltas/ui/views/payment/payment_view.mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'payment_view.desktop.dart';
import 'payment_viewmodel.dart';

class PaymentView extends StackedView<PaymentViewModel> {
  final String price;
  const PaymentView({
    super.key,
    required this.price,
  });

  @override
  Widget builder(
    BuildContext context,
    PaymentViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const PaymentViewMobile(),
      tablet: (_) => const PaymentViewDesktop(),
      desktop: (_) => const PaymentViewDesktop(),
    );
  }

  @override
  PaymentViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentViewModel(
        price: price,
      );
}
