import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBlock extends StatelessWidget {
  const CartBlock({super.key, required this.toPayment});
  final Function(String) toPayment;

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;

    ValueNotifier<num> overall = ValueNotifier<num>(0);
    void incrementOverall(int price) {
      overall.value += price;
    }

    void decreaceOverall(int price) {
      overall.value -= price;
    }

    return FutureBuilder(
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
          children: [
            DataTable(
              columns: const [
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Продукт',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Цена',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Количество',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Итого',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
              dataRowMaxHeight: 200,
              // columnSpacing: deviceWidth * 0.18,
              rows: snapshot.data!.map((order) {
                overall.value += order['price'] * order['count'];
                ValueNotifier<num> total = ValueNotifier<num>(0);
                total.value = order['price'];
                return DataRow(
                  cells: [
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.grey,
                              width: 225,
                              child: AppImage(
                                imageUrl: order['images'][0],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order['name'].toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Цвет: Неизвестный',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black54,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                CupertinoButton(
                                  padding: const EdgeInsets.all(0),
                                  child: const Text(
                                    'Удалить',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.red,
                                      fontSize: 22,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '${order['price']} ₸',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              height: 42,
                              width: 140,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          if (order['count'] > 1) {
                                            order['count']--;
                                            decreaceOverall(order['price']);
                                            total.value =
                                                order['count'] * order['price'];
                                          }
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: SvgPicture.asset(
                                        'assets/minus.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      '${order['count']}',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      incrementOverall(order['price']);

                                      setState(() {
                                        order['count']++;
                                      });
                                      total.value =
                                          order['count'] * order['price'];
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: SvgPicture.asset(
                                        'assets/plus.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ValueListenableBuilder(
                          builder: (context, value, child) => Text(
                            "${total.value.toString()} ₸",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          valueListenable: total,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const Divider(),
            ValueListenableBuilder<num>(
              builder: (context, value, child) => Row(
                children: [
                  const Spacer(
                    flex: 10,
                  ),
                  const Text(
                    'Итого: ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${overall.value} ₸",
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
              valueListenable: overall,
            ),
            const SizedBox(height: 30),
            CupertinoButton(
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
                  toPayment(overall.value.toString());
                }
              },
              child: Container(
                width: double.infinity,
                height: 66,
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Оплатить',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
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
