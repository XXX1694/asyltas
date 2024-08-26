import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileViewMobile extends ViewModelWidget<ProfileViewModel> {
  const ProfileViewMobile({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo_small.png'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        CupertinoButton(
                          padding: const EdgeInsets.only(right: 20),
                          onPressed: () {
                            viewModel.goToCartPage();
                          },
                          child: SvgPicture.asset('assets/cart.svg'),
                        ),
                        // const SizedBox(width: 12),
                        CupertinoButton(
                          padding: const EdgeInsets.only(right: 20),
                          onPressed: () {
                            viewModel.goToMenu();
                          },
                          child: SvgPicture.asset('assets/burger.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Профиль',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: kcPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FutureBuilder(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.shade300,
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/asyltas_profile.png',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Почта: ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: snapshot.data?['email'],
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Номер: ',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: snapshot.data?['phoneNumber'],
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
