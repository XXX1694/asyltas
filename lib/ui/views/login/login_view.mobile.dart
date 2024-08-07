import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginViewMobile extends ViewModelWidget<LoginViewmodel> {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, LoginViewmodel viewModel) {
    return const Scaffold(
      backgroundColor: Colors.grey,
    );
  }
}
