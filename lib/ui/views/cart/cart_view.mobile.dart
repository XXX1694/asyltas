import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartViewMobile extends ViewModelWidget<CartViewModel> {
  const CartViewMobile({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
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
                    child: CupertinoButton(
                      padding: const EdgeInsets.only(right: 20),
                      onPressed: () {
                        viewModel.goToMenu();
                      },
                      child: SvgPicture.asset('assets/burger.svg'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Корзина',
                style: GoogleFonts.montserrat(
                  color: kcPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: _loadData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Пусто'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Всего ${snapshot.data?.length ?? 0} товаров',
                          style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            snapshot.data?[index]['count'] = 1;
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 6,
                              ),
                              height: 150,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: AppImage(
                                        imageUrl: snapshot.data?[index]
                                                ['images'][0] ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data?[index]['name'],
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Неизвестно / Неизвестно',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          '${snapshot.data?[index]['price']} ₸',
                                          style: GoogleFonts.montserrat(
                                            color: kcPrimaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black45,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          if (snapshot.data?[
                                                                      index]
                                                                  ['count'] >
                                                              0) {
                                                            snapshot.data?[
                                                                    index]
                                                                ['count']--;
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 6),
                                                      child: SvgPicture.asset(
                                                        'assets/minus_mobile.svg',
                                                        width: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Text(
                                                      '${snapshot.data?[index]['count']}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        snapshot.data?[index]
                                                            ['count']++;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 6),
                                                      child: SvgPicture.asset(
                                                        'assets/plus_mobile.svg',
                                                        height: 14,
                                                        width: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // const SizedBox(height: 14),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                      //   child: Divider(height: 1),
                      // ),
                      // const SizedBox(height: 16),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Итого:',
                      //         style: GoogleFonts.montserrat(
                      //           color: Colors.black,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       Text(
                      //         'Итого:',
                      //         style: GoogleFonts.montserrat(
                      //           color: kcPrimaryColor,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () async {
                            List<dynamic>? oredersList = snapshot.data;
                            List<Map<String, dynamic>> sendData = oredersList
                                    ?.map((doc) => doc as Map<String, dynamic>)
                                    .toList() ??
                                [];
                            bool res = await addDataToOrdersCollection(
                              sendData,
                            );
                            if (res) {
                              viewModel.goToPaymentPage();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                              color: kcPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Оплатить',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
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
