import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign in with email and password
//   Future<User?> signInWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error signing in: $e');
//       }
//       return null;
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

// Future<bool> signInAndSaveToken(String email, String password) async {
//   try {
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     User? user = userCredential.user;
//     if (user != null) {
//       String idToken = user.uid;
//       // Save the token locally
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('idToken', idToken);
//       if (kDebugMode) {
//         print('ID Token saved locally.');
//       }
//       return true;
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error signing in or saving token: $e');
//     }
//     return false;
//   }
//   return false;
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

Future<bool> addToFavoritesField(List<Map<String, dynamic>> newData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final prefs = await SharedPreferences.getInstance();
  String? docID = prefs.getString('idToken');
  try {
    // Reference to the user document
    DocumentReference userRef = firestore.collection('users').doc(docID);

    // Update the newOrder field by appending newData
    await userRef.update({'favorites': FieldValue.arrayUnion(newData)});

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
  List<Map<String, dynamic>> newData,
  String comment,
  String name,
  String phoneNumber,
  int total,
) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    // Reference to the orders collection
    // final prefs = await SharedPreferences.getInstance();
    // String? docID = prefs.getString('idToken');

    CollectionReference ordersRef = firestore.collection('orders');
    // final docRef = FirebaseFirestore.instance.collection('users').doc(docID);

    // final docSnapshot = await docRef.get();
    // Map<String, dynamic> data = {};
    // if (docSnapshot.exists) {
    //   data = docSnapshot.data() ?? {};
    // } else {
    //   if (kDebugMode) {
    //     print('Document does not exist');
    //   }
    // }
    // Add newData to the orders collection
    await ordersRef.add(
      {
        'data': newData,
        'name': name,
        'phoneNumber': phoneNumber,
        'status': 'Не обработан',
        'comment': comment,
        'timestamp': DateTime.now().toString(),
        'total': total,
      },
    );

    // DocumentReference docRefUser =
    //     FirebaseFirestore.instance.collection('users').doc(docID);

    // await docRefUser.update({
    //   'newOrder': FieldValue.delete(),
    // });

    if (kDebugMode) {
      print('Field newOrder deleted successfully.');
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

Future<bool> deleteElementFromList(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idToken = prefs.getString('idToken');
  try {
    // Reference to the document in the 'users' collection
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(idToken);

    // Fetch the current document
    DocumentSnapshot docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw Exception("Document does not exist");
    }

    // Get the current list and cast it to Map<String, dynamic>
    Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    List<dynamic> newOrder = data['newOrder'] ?? [];

    if (index < 0 || index >= newOrder.length) {
      throw Exception("Index out of range");
    }

    // Remove the element from the list
    newOrder.removeAt(index);

    // Update the document with the new list
    await docRef.update({'newOrder': newOrder});
    if (kDebugMode) {
      print("Element removed successfully");
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
    return false;
  }
}

Future<Map<String, dynamic>?> getUserData() async {
  try {
    // Get the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the userDocId from SharedPreferences
    final userDocId = prefs.getString('idToken');

    if (userDocId == null) {
      throw Exception('No userDocId found in SharedPreferences');
    }

    // Access Firestore instance
    final firestore = FirebaseFirestore.instance;

    // Fetch the user document from the 'users' collection
    final userDoc = await firestore.collection('users').doc(userDocId).get();

    if (!userDoc.exists) {
      throw Exception('User document does not exist');
    }

    // Return the user data
    return userDoc.data();
  } catch (e) {
    if (kDebugMode) {
      print('Error getting user data: $e');
    }
    return null;
  }
}

// Future<bool> registerUser({
//   required String email,
//   required String password,
//   required String name,
//   required String surname,
//   required String phoneNumber,
// }) async {
//   try {
//     // Register the user with email and password
//     UserCredential userCredential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     User? user = userCredential.user;
//     if (user != null) {
//       // Save additional user details to Firestore
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'name': name,
//         'surname': surname,
//         'phoneNumber': phoneNumber,
//         'email': email,
//       });

//       if (kDebugMode) {
//         print('User registered and additional details saved.');
//       }
//       bool res = await signInAndSaveToken(
//         email,
//         password,
//       );
//       if (res) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error registering user: $e');
//     }
//     return false;
//   }
//   return false;
// }
