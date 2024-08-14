import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/app_iamge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBlock extends StatelessWidget {
  const CartBlock({super.key, required this.toPayment});
  final Function toPayment;
  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) => Column(
        children: [
          DataTable(
            columns: [
              DataColumn(
                label: Center(
                  child: Text(
                    'Продукт',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Цена',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'Количество',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'Итого',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            dataRowMaxHeight: 200,
            // columnSpacing: deviceWidth * 0.18,
            rows: snapshot.data!.map((order) {
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
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Цвет: Неизвестный',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black54,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 12),
                              CupertinoButton(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  'Удалить',
                                  style: GoogleFonts.montserrat(
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
                        style: GoogleFonts.montserrat(
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
                      child: Text(
                        order['price'].toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
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
                      child: Text(
                        order['price'].toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
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
              bool res = await addDataToOrdersCollection(sendData);
              if (res) {
                toPayment();
              }
            },
            child: Container(
              width: double.infinity,
              height: 66,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Оплатить',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
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
