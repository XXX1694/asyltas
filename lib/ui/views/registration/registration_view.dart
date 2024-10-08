import 'package:asyltas/ui/views/registration/registration_view.mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'registration_view.desktop.dart';
import 'registration_viewmodel.dart';

class RegistrationView extends StackedView<RegistrationViewmodel> {
  const RegistrationView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewmodel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const RegistrationViewMobile(),
      tablet: (_) => const RegistrationViewDesktop(),
      desktop: (_) => const RegistrationViewDesktop(),
    );
  }

  @override
  RegistrationViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewmodel();
}
