import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'payment_viewmodel.dart';

class PaymentViewTablet extends ViewModelWidget<PaymentViewModel> {
  const PaymentViewTablet({super.key});

  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
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
