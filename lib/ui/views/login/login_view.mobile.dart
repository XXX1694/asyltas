import 'package:asyltas/ui/widgets/login_screen/login_form_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginViewMobile extends ViewModelWidget<LoginViewmodel> {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context, LoginViewmodel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    viewModel.goToMenu();
                  },
                  child: SvgPicture.asset('assets/burger.svg'),
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo_small.png',
                  height: 60,
                ),
              ),
              Expanded(
                child: LoginFormMobile(
                  toRegistration: viewModel.goToRegistrationPage,
                  toMainPage: viewModel.goToMainPage,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
