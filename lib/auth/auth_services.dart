import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      print('Error signing in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

Future<void> signInAndSaveToken(String email, String password) async {
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
      print('ID Token saved locally.');
    }
  } catch (e) {
    print('Error signing in or saving token: $e');
  }
}

Future<void> deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('idToken');
  print('ID Token deleted.');
}

Future<String?> getSavedToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idToken = prefs.getString('idToken');
  return idToken;
}

Future<void> registerUser({
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

      print('User registered and additional details saved.');
    }
  } catch (e) {
    print('Error registering user: $e');
  }
}
