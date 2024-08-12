import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileViewTablet extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewTablet({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
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
