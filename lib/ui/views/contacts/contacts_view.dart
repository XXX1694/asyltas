import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'contacts_view.desktop.dart';
import 'contacts_view.tablet.dart';
import 'contacts_view.mobile.dart';
import 'contacts_viewmodel.dart';

class ContactsView extends StackedView<ContactsViewModel> {
  const ContactsView({super.key});
  @override
  Widget builder(
    BuildContext context,
    ContactsViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const ContactsViewMobile(),
      tablet: (_) => const ContactsViewTablet(),
      desktop: (_) => const ContactsViewDesktop(),
    );
  }

  @override
  ContactsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ContactsViewModel();
}
