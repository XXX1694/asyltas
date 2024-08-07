import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.toLoginPage,
    required this.toCatalogPage,
    required this.toMainPage,
    required this.toRegistrationPage,
    required this.toSalesPage,
  });
  final Function toLoginPage;
  final Function toCatalogPage;
  final Function toRegistrationPage;
  final Function toSalesPage;
  final Function toMainPage;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return SizedBox(
              // padding: const EdgeInsets.symmetric(horizontal: 160),
              height: 56,
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo_small.png',
                        height: 47,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 13,
                          ),
                          child: SvgPicture.asset(
                            'assets/search.svg',
                            width: 17,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 13,
                          ),
                          child: SvgPicture.asset(
                            'assets/cart.svg',
                            width: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 13,
                          ),
                          child: SvgPicture.asset(
                            'assets/profile.svg',
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          toMainPage();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 13,
                          ),
                          child: Center(
                            child: Text(
                              'Главная',
                              style: GoogleFonts.montserrat(
                                color: kcPrimaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          toCatalogPage();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 13,
                          ),
                          child: Center(
                            child: Text(
                              'Каталог',
                              style: GoogleFonts.montserrat(
                                color: kcPrimaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              // padding: const EdgeInsets.symmetric(horizontal: 160),
              height: 56,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_small.png',
                    height: 47,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      toMainPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                      child: Center(
                        child: Text(
                          'Главная',
                          style: GoogleFonts.montserrat(
                            color: kcPrimaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toCatalogPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                      child: Center(
                        child: Text(
                          'Каталог',
                          style: GoogleFonts.montserrat(
                            color: kcPrimaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                      child: Center(
                        child: Text(
                          'Скидки',
                          style: GoogleFonts.montserrat(
                            color: kcPrimaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toLoginPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                      child: Center(
                        child: Text(
                          'Войти',
                          style: GoogleFonts.montserrat(
                            color: kcPrimaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toRegistrationPage();
                    },
                    child: Container(
                      height: double.infinity,
                      margin: const EdgeInsets.only(left: 25),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 20),
                            color: kcBlack.withOpacity(0.15),
                            blurRadius: 15,
                          ),
                        ],
                        color: kcPrimaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Регестрация',
                          style: GoogleFonts.montserrat(
                            color: kcWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
