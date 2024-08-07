import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'registration_viewmodel.dart';

class RegistrationViewTablet extends ViewModelWidget<RegistrationViewmodel> {
  const RegistrationViewTablet({super.key});

  @override
  Widget build(BuildContext context, RegistrationViewmodel viewModel) {
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
