// // ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously, invalid_use_of_protected_member

// import 'package:asyltas/auth/auth_services.dart';
// import 'package:asyltas/ui/common/app_colors.dart';
// import 'package:asyltas/ui/widgets/cart_screen/comment_field.dart';

// import 'package:asyltas/ui/widgets/home_screen/home_bottom.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// typedef FutureCallbackFunction = Future Function(String price);

// class CartMobile extends StatefulWidget {
//   const CartMobile({
//     super.key,
//     required this.goToFavoritesPage,
//     required this.goToMenu,
//     required this.showPayment,
//   });

//   final Function goToFavoritesPage;
//   final Function goToMenu;
//   final FutureCallbackFunction showPayment;

//   @override
//   State<CartMobile> createState() => _CartMobileState();
// }

// class _CartMobileState extends State<CartMobile> {
//   late TextEditingController comment;
//   @override
//   void initState() {
//     comment = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     comment.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ValueNotifier<List<dynamic>> cartProductsNotifier =
//         ValueNotifier<List<dynamic>>([]);
//     ValueNotifier<num> overall = ValueNotifier<num>(0);

//     Future<void> loadData() async {
//       final docID = await getDocIDFromSharedPreferences();
//       if (docID != null) {
//         List<dynamic> orders = await getNewOrderFromFirestore(docID);
//         cartProductsNotifier.value = orders;
//         overall.value = orders.fold<num>(
//           0,
//           (previousValue, element) =>
//               previousValue + (element['price'] * element['count']),
//         );
//       }
//     }

//     void incrementOverall(int price) {
//       overall.value += price;
//     }

//     void decrementOverall(int price) {
//       overall.value -= price;
//     }

//     Future<bool> deleteElementFromList(int index) async {
//       final docID = await getDocIDFromSharedPreferences();
//       if (docID != null) {
//         try {
//           final docRef =
//               FirebaseFirestore.instance.collection('users').doc(docID);
//           final docSnapshot = await docRef.get();
//           if (docSnapshot.exists) {
//             List<dynamic> newOrder =
//                 List.from(docSnapshot.data()?['newOrder'] ?? []);
//             newOrder.removeAt(index);
//             await docRef.update({'newOrder': newOrder});
//             return true;
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             print('Error deleting item: $e');
//           }
//         }
//       }
//       return false;
//     }

//     return SafeArea(
//       child: FutureBuilder<void>(
//         future: loadData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 28),
//               SizedBox(
//                 height: 30,
//                 width: double.infinity,
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: SvgPicture.asset(
//                           'assets/logo.svg',
//                           height: 28,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Row(
//                         children: [
//                           const Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               widget.goToFavoritesPage();
//                             },
//                             child: Container(
//                               height: 32,
//                               width: 32,
//                               decoration: BoxDecoration(
//                                 color: kcPrimaryColor.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/like.svg',
//                                   width: 22,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           GestureDetector(
//                             onTap: () {
//                               widget.goToMenu();
//                             },
//                             child: SvgPicture.asset('assets/burger.svg'),
//                           ),
//                           const SizedBox(width: 12)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Text(
//                   'Корзина',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     color: kcPrimaryColor,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: ValueListenableBuilder<List<dynamic>>(
//                   valueListenable: cartProductsNotifier,
//                   builder: (context, cartProducts, _) {
//                     if (cartProducts.isEmpty) {
//                       return const Column(
//                         children: [
//                           Expanded(child: Center(child: Text('Пусто'))),
//                           SizedBox(height: 16),
//                           HomeBottom(),
//                           SizedBox(height: 16),
//                           Divider(
//                             color: Colors.black12,
//                             height: 1,
//                           ),
//                           SizedBox(height: 16),
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               '© 2024 Asyltas Разработано galab.kz',
//                               style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Colors.black54,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 letterSpacing: -0.41,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                         ],
//                       );
//                     }
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           child: Text(
//                             'Всего ${cartProducts.length} товаров',
//                             style: const TextStyle(
//                               fontFamily: 'Montserrat',
//                               color: Colors.black54,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 18),
//                         Flexible(
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemCount: cartProducts.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 margin: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 6,
//                                 ),
//                                 height: 150,
//                                 width: double.infinity,
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       height: 150,
//                                       width: 150,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(4),
//                                         child: Image.network(
//                                           cartProducts[index]['images'][0] ??
//                                               '',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             cartProducts[index]['name'],
//                                             style: const TextStyle(
//                                               fontFamily: 'Montserrat',
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           const Text(
//                                             'Неизвестно / Неизвестно',
//                                             style: TextStyle(
//                                               fontFamily: 'Montserrat',
//                                               color: Colors.black54,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const SizedBox(height: 16),
//                                           Text(
//                                             '${cartProducts[index]['price']} ₸',
//                                             style: const TextStyle(
//                                               fontFamily: 'Montserrat',
//                                               color: kcPrimaryColor,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           StatefulBuilder(
//                                             builder: (context, setState) {
//                                               return Row(
//                                                 children: [
//                                                   Container(
//                                                     height: 30,
//                                                     decoration: BoxDecoration(
//                                                       // border: Border.all(
//                                                       //     color:
//                                                       //         Colors.black45,
//                                                       //     width: 1),
//                                                       color: kcPrimaryColor
//                                                           .withOpacity(0.2),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4),
//                                                     ),
//                                                     child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         CupertinoButton(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(0),
//                                                           onPressed: () async {
//                                                             if (cartProducts[
//                                                                         index]
//                                                                     ['count'] >
//                                                                 1) {
//                                                               setState(() {
//                                                                 decrementOverall(
//                                                                     cartProducts[
//                                                                             index]
//                                                                         [
//                                                                         'price']);
//                                                                 cartProducts[
//                                                                         index]
//                                                                     ['count']--;
//                                                               });
//                                                             } else {}
//                                                           },
//                                                           child:
//                                                               SvgPicture.asset(
//                                                             'assets/minus_mobile.svg',
//                                                             width: 13,
//                                                           ),
//                                                         ),
//                                                         Flexible(
//                                                           child: Text(
//                                                             '${cartProducts[index]['count']}',
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontFamily:
//                                                                   'Montserrat',
//                                                               fontSize: 17,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ),
//                                                         ),
//                                                         CupertinoButton(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(0),
//                                                           onPressed: () {
//                                                             incrementOverall(
//                                                                 cartProducts[
//                                                                         index]
//                                                                     ['price']);
//                                                             setState(() {
//                                                               cartProducts[
//                                                                       index]
//                                                                   ['count']++;
//                                                             });
//                                                           },
//                                                           child:
//                                                               SvgPicture.asset(
//                                                             'assets/plus_mobile.svg',
//                                                             width: 13,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Spacer(),
//                                                   CupertinoButton(
//                                                     padding:
//                                                         const EdgeInsets.all(0),
//                                                     onPressed: () async {
//                                                       bool res =
//                                                           await deleteElementFromList(
//                                                               index);
//                                                       if (res) {
//                                                         cartProductsNotifier
//                                                             .value
//                                                             .removeAt(index);
//                                                         cartProductsNotifier
//                                                             .notifyListeners();
//                                                         showDialog(
//                                                           context: context,
//                                                           barrierDismissible:
//                                                               true,
//                                                           builder: (BuildContext
//                                                               context) {
//                                                             return AlertDialog(
//                                                               buttonPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               contentPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               actionsPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               iconPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               insetPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               titlePadding:
//                                                                   const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           0,
//                                                                       vertical:
//                                                                           16),

//                                                               title:
//                                                                   const Center(
//                                                                 child: Text(
//                                                                   'Товар удален из корзины!',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                         15,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                               ),
//                                                               // content: const Text('Добавлен в корзину'),
//                                                               shape:
//                                                                   RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             2.0),
//                                                               ),
//                                                             );
//                                                           },
//                                                         );
//                                                       } else {
//                                                         showDialog(
//                                                           context: context,
//                                                           barrierDismissible:
//                                                               true,
//                                                           builder: (BuildContext
//                                                               context) {
//                                                             return AlertDialog(
//                                                               buttonPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               contentPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               actionsPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               iconPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               insetPadding:
//                                                                   const EdgeInsets
//                                                                       .all(0),
//                                                               titlePadding:
//                                                                   const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           0,
//                                                                       vertical:
//                                                                           16),

//                                                               title:
//                                                                   const Center(
//                                                                 child: Text(
//                                                                   'Товар не удален из корзины!',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize:
//                                                                         15,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                               ),
//                                                               // content: const Text('Добавлен в корзину'),
//                                                               shape:
//                                                                   RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             2.0),
//                                                               ),
//                                                             );
//                                                           },
//                                                         );
//                                                       }
//                                                     },
//                                                     child: Container(
//                                                       height: 28,
//                                                       width: 28,
//                                                       decoration: BoxDecoration(
//                                                         color: kcPrimaryColor
//                                                             .withOpacity(0.2),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           100,
//                                                         ),
//                                                       ),
//                                                       child: Center(
//                                                         child: SvgPicture.asset(
//                                                           'assets/close.svg',
//                                                           height: 12,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 12),
//                           child: Divider(
//                             height: 1,
//                             color: Colors.black12,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         CommentTextField(controller: comment),
//                         const SizedBox(height: 12),
//                         ValueListenableBuilder<num>(
//                           valueListenable: overall,
//                           builder: (context, value, child) => Row(
//                             children: [
//                               const Spacer(flex: 10),
//                               const Text(
//                                 'Итого: ',
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 "${overall.value} ₸",
//                                 style: const TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const Spacer(flex: 1),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           child: CupertinoButton(
//                             padding: const EdgeInsets.all(0),
//                             onPressed: () async {
//                               List<Map<String, dynamic>> sendData = cartProducts
//                                   .map((doc) => doc as Map<String, dynamic>)
//                                   .toList();
//                               bool res = await addDataToOrdersCollection(
//                                 sendData,
//                                 comment.text.isEmpty
//                                     ? "Без комментария к заказу"
//                                     : comment.text,
//                               );
//                               if (res) {
//                                 widget.showPayment(overall.value.toString());
//                               }
//                             },
//                             child: Container(
//                               width: double.infinity,
//                               height: 44,
//                               decoration: BoxDecoration(
//                                 color: kcPrimaryColor,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   'Оплатить',
//                                   style: TextStyle(
//                                     fontFamily: 'Montserrat',
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> getNewOrderFromFirestore(String docID) async {
//     try {
//       final docRef = FirebaseFirestore.instance.collection('users').doc(docID);
//       final docSnapshot = await docRef.get();

//       if (docSnapshot.exists) {
//         final data = docSnapshot.data();
//         return data?['newOrder'] as List<dynamic>;
//       } else {
//         if (kDebugMode) {
//           print('Document does not exist');
//         }
//         return [];
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching document: $e');
//       }
//       return [];
//     }
//   }

//   Future<String?> getDocIDFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('idToken'); // Replace 'idToken' with your actual key
//   }
// }
