import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future createUser(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
    notifyListeners();
  }

}
