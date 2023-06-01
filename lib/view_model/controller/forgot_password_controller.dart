import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';


class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setloading(true);
    try {
      await auth.sendPasswordResetEmail(email: email)
          .then((value) {
           
        setloading(false);
        Utils.toastMessage('Please check your email to recover your password');
        Navigator.pushNamed(context, RouteName.loginScreen);
      });
    } on FirebaseAuthException catch (e) {
      setloading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
