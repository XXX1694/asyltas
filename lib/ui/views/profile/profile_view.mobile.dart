import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              height: 40,
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        'assets/logo.svg',
                        height: 28,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            viewModel.goToFavoritesPage();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: kcPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/like.svg',
                                width: 22,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        FutureBuilder(
                            future: _loadData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.goToCartPage();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/cart1.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return const SizedBox();
                              }
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.goToCartPage();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/cart1.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  viewModel.goToCartPage();
                                },
                                child: SizedBox(
                                  width: 42,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          'assets/cart1.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 18,
                                          width: 18,
                                          decoration: BoxDecoration(
                                            color: kcPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data!.length.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            viewModel.goToMenu();
                          },
                          child: SvgPicture.asset('assets/burger.svg'),
                        ),
                        const SizedBox(width: 12)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        const Text(
                          'Профиль',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: kcPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              text:
                                                  snapshot.data?['phoneNumber'],
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
                  const Spacer(),
                  const SizedBox(height: 16),
                  const HomeBottom(),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.black12,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '© 2024 Asyltas Разработано galab.kz',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.41,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> getNewOrderFromFirestore(String docID) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(docID);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return data?['newOrder'] as List<dynamic>;
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document: $e');
      }
      return [];
    }
  }

  Future<String?> getDocIDFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('idToken'); // Replace 'docID' with your actual key
  }

  Future<List<dynamic>> _loadData() async {
    final docID = await getDocIDFromSharedPreferences();
    if (docID != null) {
      List<dynamic>? orders = await getNewOrderFromFirestore(docID);
      return orders;
    } else {
      return [];
    }
  }
}
