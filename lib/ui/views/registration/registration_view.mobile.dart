import 'package:asyltas/ui/widgets/registration_screen/registration_form_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'registration_viewmodel.dart';

class RegistrationViewMobile extends ViewModelWidget<RegistrationViewmodel> {
  const RegistrationViewMobile({super.key});

  @override
  Widget build(BuildContext context, RegistrationViewmodel viewModel) {
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
                  padding: const EdgeInsets.only(right: 20),
                  onPressed: () {
                    viewModel.goToMenu();
                  },
                  child: SvgPicture.asset('assets/burger.svg'),
                ),
              ),
              Expanded(
                child: RegistrationFormMobile(
                  toLogin: viewModel.goToLoginPage,
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
