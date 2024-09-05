import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/cart_screen/comment_field.dart';
import 'package:asyltas/ui/widgets/cart_screen/name_field.dart';

import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
import 'package:asyltas/ui/widgets/login_screen/phone_field_mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

typedef FutureCallbackFunction = Future Function(String price);

class CartMobileNew extends StatefulWidget {
  const CartMobileNew({
    super.key,
    required this.goToFavoritesPage,
    required this.goToMenu,
    required this.showPayment,
  });

  final Function goToFavoritesPage;
  final Function goToMenu;
  final FutureCallbackFunction showPayment;

  @override
  State<CartMobileNew> createState() => _CartMobileNewState();
}

class _CartMobileNewState extends State<CartMobileNew> {
  late TextEditingController commentContrller;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  @override
  void initState() {
    commentContrller = TextEditingController();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentContrller.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                    child: GestureDetector(
                      onTap: () {
                        widget.goToMenu();
                      },
                      child: SvgPicture.asset(
                        'assets/logo.svg',
                        height: 28,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          widget.goToFavoritesPage();
                        },
                        child: SizedBox(
                          width: 42,
                          height: 40,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: kcPrimaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/like.svg',
                                  ),
                                ),
                              ),
                              Consumer<FavoritesProvider>(
                                builder: (context, favorites, child) {
                                  if (favorites.items.isEmpty) {
                                    return const SizedBox();
                                  } else {
                                    return Align(
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
                                            favorites.items.length.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
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
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          widget.goToMenu();
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
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                if (cart.items.isEmpty) {
                  return const Column(
                    children: [
                      Expanded(child: Center(child: Text('Пусто'))),
                      SizedBox(height: 16),
                      HomeBottom(),
                      SizedBox(height: 16),
                      Divider(
                        color: Colors.black12,
                        height: 1,
                      ),
                      SizedBox(height: 16),
                      Align(
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
                      SizedBox(height: 16),
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Всего ${cart.items.length} товаров',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cart.items.length,
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
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        cart.items[index].images?[0] ?? '',
                                        fit: BoxFit.cover,
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
                                          cart.items[index].name ?? 'Без имени',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
                                          '${cart.items[index].price} ₸',
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
                                            return Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color:
                                                    //         Colors.black45,
                                                    //     width: 1),
                                                    color: kcPrimaryColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CupertinoButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        onPressed: () async {
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .decrementCount(
                                                                  cart.items[
                                                                      index]);
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/minus_mobile.svg',
                                                          width: 13,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${cart.items[index].count ?? 1}',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 17,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      CupertinoButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .incrementCount(
                                                                  cart.items[
                                                                      index]);
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/plus_mobile.svg',
                                                          width: 13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                CupertinoButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  onPressed: () async {
                                                    context
                                                        .read<CartProvider>()
                                                        .removeItem(
                                                            cart.items[index]);
                                                    _showTimedAlertDialog(
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 28,
                                                    width: 28,
                                                    decoration: BoxDecoration(
                                                      color: kcPrimaryColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        'assets/close.svg',
                                                        height: 12,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          height: 1,
                          color: Colors.black12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      NameFieldMobile(controller: nameController),
                      const SizedBox(height: 12),
                      PhoneFieldMobile(controller: phoneController),
                      const SizedBox(height: 12),
                      CommentTextField(controller: commentContrller),
                      const SizedBox(height: 12),
                      Row(
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
                            "${context.read<CartProvider>().totalPrice} ₸",
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
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () async {
                            if (phoneController.text.isEmpty) {
                            } else if (nameController.text.isEmpty) {
                            } else {
                              List<Map<String, dynamic>> sendData = cart.items
                                  .map((doc) => doc.toJson())
                                  .toList();
                              bool res = await addDataToOrdersCollection(
                                sendData,
                                commentContrller.text.isEmpty
                                    ? "Без комментария к заказу"
                                    : commentContrller.text,
                                nameController.text,
                                phoneController.text,
                              );
                              if (res) {
                                // ignore: use_build_context_synchronously
                                widget.showPayment(context
                                    .read<CartProvider>()
                                    .totalPrice
                                    .toString());
                                context.read<CartProvider>().clearCart();
                              }
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTimedAlertDialog(BuildContext context) {
    // Show the dialog
    showDialog(
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
              'Товар удален!',
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
