import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

Future<bool> signInAndSaveToken(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      String idToken = user.uid;
      // Save the token locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('idToken', idToken);
      if (kDebugMode) {
        print('ID Token saved locally.');
      }
      return true;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error signing in or saving token: $e');
    }
    return false;
  }
  return false;
}

Future<void> deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('idToken');
  if (kDebugMode) {
    print('ID Token deleted.');
  }
}

Future<String?> getSavedToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idToken = prefs.getString('idToken');
  return idToken;
}

Future<bool> checkAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idToken = prefs.getString('idToken');
  if (idToken != null) {
    return true;
  } else {
    return false;
  }
}

Future<bool> addToNewOrderField(
    String docId, List<Map<String, dynamic>> newData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    // Reference to the user document
    DocumentReference userRef = firestore.collection('users').doc(docId);

    // Update the newOrder field by appending newData
    await userRef.update({'newOrder': FieldValue.arrayUnion(newData)});

    if (kDebugMode) {
      print('Data added to newOrder successfully');
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('Error adding data to newOrder: $e');
    }
    return false;
    // Handle any errors here
  }
}

Future<bool> addDataToOrdersCollection(
    List<Map<String, dynamic>> newData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    // Reference to the orders collection
    final prefs = await SharedPreferences.getInstance();
    String? docID = prefs.getString('idToken');

    CollectionReference ordersRef = firestore.collection('orders');
    final docRef = FirebaseFirestore.instance.collection('users').doc(docID);

    final docSnapshot = await docRef.get();
    Map<String, dynamic> data = {};
    if (docSnapshot.exists) {
      data = docSnapshot.data() ?? {};
    } else {
      if (kDebugMode) {
        print('Document does not exist');
      }
    }
    // Add newData to the orders collection
    await ordersRef.add(
      {
        'data': newData,
        'user_info': data,
        'timestamp': DateTime.now(),
        'count': 1,
      },
    );

    if (kDebugMode) {
      print('Data added to orders collection successfully');
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('Error adding data to orders collection: $e');
    }
    return false;
    // Handle any errors here
  }
}

Future<bool> registerUser({
  required String email,
  required String password,
  required String name,
  required String surname,
  required String phoneNumber,
}) async {
  try {
    // Register the user with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    if (user != null) {
      // Save additional user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'surname': surname,
        'phoneNumber': phoneNumber,
        'email': email,
      });

      if (kDebugMode) {
        print('User registered and additional details saved.');
      }
      return true;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error registering user: $e');
    }
    return false;
  }
  return false;
}
