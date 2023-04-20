import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hungryhub_adminpanel/view/authentication/sign_in.dart';

import '../view/home.dart';

final emailcontrol = TextEditingController();
final passcontroller = TextEditingController();

class SignInProvider with ChangeNotifier {
  Future<void> signIn(context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontrol.text.trim(),
              password: passcontroller.text.trim())
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetailsScreen(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("Email doesn't Exist"),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("password doesn't Exist"),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 300),
            content: Text("invalid-email"),
          ),
        );
      }
    }
    notifyListeners();
  }

  Future logout(context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
    });
  }
}
