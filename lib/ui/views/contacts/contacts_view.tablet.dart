import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'contacts_viewmodel.dart';

class ContactsViewTablet extends ViewModelWidget<ContactsViewModel> {
  const ContactsViewTablet({super.key});

  @override
  Widget build(BuildContext context, ContactsViewModel viewModel) {
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
