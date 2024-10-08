// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously, invalid_use_of_protected_member, unused_element

import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/favorites_screen/cart_button.dart';
import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'favorites_viewmodel.dart';

class FavoritesViewMobile extends ViewModelWidget<FavoritesViewModel> {
  const FavoritesViewMobile({super.key});

  @override
  Widget build(BuildContext context, FavoritesViewModel viewModel) {
    ValueNotifier<List<dynamic>> cartProductsNotifier =
        ValueNotifier<List<dynamic>>([]);
    ValueNotifier<num> overall = ValueNotifier<num>(0);

    Future<void> loadData() async {
      final docID = await getDocIDFromSharedPreferences();
      if (docID != null) {
        List<dynamic> orders = await getNewOrderFromFirestore(docID);
        cartProductsNotifier.value = orders;
        overall.value = orders.fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element['price'] * element['count']),
        );
      }
    }

    void incrementOverall(int price) {
      overall.value += price;
    }

    void decrementOverall(int price) {
      overall.value -= price;
    }

    Future<bool> deleteElementFromList(int index) async {
      final docID = await getDocIDFromSharedPreferences();
      if (docID != null) {
        try {
          final docRef =
              FirebaseFirestore.instance.collection('users').doc(docID);
          final docSnapshot = await docRef.get();
          if (docSnapshot.exists) {
            List<dynamic> newOrder =
                List.from(docSnapshot.data()?['favorites'] ?? []);
            newOrder.removeAt(index);
            await docRef.update({'favorites': newOrder});
            return true;
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error deleting item: $e');
          }
        }
      }
      return false;
    }

    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.goToMainPage();
                        },
                        child: const Text(
                          'ASYLTAS',
                          style: TextStyle(
                            color: newBlack,
                            fontSize: 17,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          viewModel.goToCartPage();
                        },
                        child: SizedBox(
                          width: 31,
                          height: 31,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SvgPicture.asset(
                                  'assets/cart1.svg',
                                ),
                              ),
                              Consumer<CartProvider>(
                                builder: (context, favorites, child) {
                                  if (favorites.items.isEmpty) {
                                    return const SizedBox();
                                  } else {
                                    return Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          color: newMainColor,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Text(
                                            favorites.items.length.toString(),
                                            style: const TextStyle(
                                              color: newWhite,
                                              fontSize: 11,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          viewModel.goToMenu();
                        },
                        child: SvgPicture.asset('assets/menu.svg'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Избранные',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: newMainColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favorites, child) {
                      if (favorites.items.isEmpty) {
                        return const Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Пусто',
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Всего ${favorites.items.length} товаров',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  color: newBlack54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Flexible(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: favorites.items.length,
                                itemBuilder: (context, index) {
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  const Duration(seconds: 0),
                                              fadeOutDuration:
                                                  const Duration(seconds: 0),
                                              imageUrl: favorites.items[index]
                                                      .images?[0] ??
                                                  '',
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) {
                                                return Container(
                                                  color: Colors.grey.shade200,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                );
                                              },
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
                                                favorites.items[index].name ??
                                                    'Без имени',
                                                style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: newBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'В пачке: ${favorites.items[index].numberLeft ?? 1} шт',
                                                style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: newBlack,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${favorites.items[index].price} ₸',
                                                style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  color: newMainColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const Spacer(),
                                              CartButton(
                                                product: favorites.items[index],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const HomeBottom(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showTimedAlertDialog(BuildContext context) {
    // Show the dialog
    final dialog = showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          iconPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),

          title: const Center(
            child: Text(
              'Добавлен в корзину!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // content: const Text('Добавлен в корзину'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        );
      },
    );

    // Automatically dismiss the dialog after 1 second
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

    // Optional: Ensure the dialog is dismissed if it's already closed
    dialog.whenComplete(() {
      // Perform any additional actions if needed
    });
  }

  Future<List<dynamic>> getNewOrderFromFirestore(String docID) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(docID);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return data?['favorites'] as List<dynamic>;
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
    return prefs.getString('idToken'); // Replace 'idToken' with your actual key
  }

  Future<List<dynamic>> getNewOrderFromFirestore1(String docID) async {
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

  Future<String?> getDocIDFromSharedPreferences1() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('idToken'); // Replace 'docID' with your actual key
  }

  Future<List<dynamic>> _loadData() async {
    final docID = await getDocIDFromSharedPreferences1();
    if (docID != null) {
      List<dynamic>? orders = await getNewOrderFromFirestore1(docID);
      return orders;
    } else {
      return [];
    }
  }
}
