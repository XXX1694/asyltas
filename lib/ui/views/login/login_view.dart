import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'login_view.desktop.dart';
import 'login_view.tablet.dart';
import 'login_view.mobile.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewmodel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewmodel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const LoginViewMobile(),
      tablet: (_) => const LoginViewTablet(),
      desktop: (_) => const LoginViewDesktop(),
    );
  }

  @override
  LoginViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewmodel();
}