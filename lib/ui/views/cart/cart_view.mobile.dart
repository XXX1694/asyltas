import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartViewMobile extends ViewModelWidget<CartViewModel> {
  const CartViewMobile({super.key});

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
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
                List.from(docSnapshot.data()?['newOrder'] ?? []);
            newOrder.removeAt(index);
            await docRef.update({'newOrder': newOrder});
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
      backgroundColor: Colors.white,
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Корзина',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: kcPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ValueListenableBuilder<List<dynamic>>(
                    valueListenable: cartProductsNotifier,
                    builder: (context, cartProducts, _) {
                      if (cartProducts.isEmpty) {
                        return const Center(child: Text('Пусто'));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Всего ${cartProducts.length} товаров',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cartProducts.length,
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
                                              BorderRadius.circular(2),
                                          child: AppImage(
                                            imageUrl: cartProducts[index]
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
                                              cartProducts[index]['name'],
                                              style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Неизвестно / Неизвестно',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              '${cartProducts[index]['price']} ₸',
                                              style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: kcPrimaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const Spacer(),
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
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CupertinoButton(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          onPressed: () async {
                                                            decrementOverall(
                                                                cartProducts[
                                                                        index]
                                                                    ['price']);
                                                            if (cartProducts[
                                                                        index]
                                                                    ['count'] >
                                                                1) {
                                                              setState(() {
                                                                cartProducts[
                                                                        index]
                                                                    ['count']--;
                                                              });
                                                            } else {
                                                              bool res =
                                                                  await deleteElementFromList(
                                                                      index);
                                                              if (res) {
                                                                cartProductsNotifier
                                                                    .value
                                                                    .removeAt(
                                                                        index);
                                                                cartProductsNotifier
                                                                    .notifyListeners();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    content:
                                                                        Text(
                                                                      'Товар удален из корзины',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    content:
                                                                        Text(
                                                                      'Товар не удален из корзины',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/minus_mobile.svg',
                                                              width: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4),
                                                        child: Text(
                                                          '${cartProducts[index]['count']}',
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 18),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: CupertinoButton(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          onPressed: () {
                                                            incrementOverall(
                                                                cartProducts[
                                                                        index]
                                                                    ['price']);
                                                            setState(() {
                                                              cartProducts[
                                                                      index]
                                                                  ['count']++;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/plus_mobile.svg',
                                                              height: 14,
                                                              width: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
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
                          const SizedBox(height: 20),
                          const Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                          const SizedBox(height: 12),
                          ValueListenableBuilder<num>(
                            valueListenable: overall,
                            builder: (context, value, child) => Row(
                              children: [
                                const Spacer(flex: 10),
                                const Text(
                                  'Итого: ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${overall.value} ₸",
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(flex: 1),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () async {
                                List<Map<String, dynamic>> sendData =
                                    cartProducts
                                        .map((doc) =>
                                            doc as Map<String, dynamic>)
                                        .toList();
                                bool res =
                                    await addDataToOrdersCollection(sendData);
                                if (res) {
                                  viewModel.goToPaymentPage(
                                      overall.value.toString());
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Оплатить',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
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
    return prefs.getString('idToken'); // Replace 'idToken' with your actual key
  }
}
