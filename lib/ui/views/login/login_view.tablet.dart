import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginViewTablet extends ViewModelWidget<LoginViewmodel> {
  const LoginViewTablet({super.key});

  @override
  Widget build(BuildContext context, LoginViewmodel viewModel) {
    return const Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}
