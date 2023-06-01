import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../services/session_manager.dart';


class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) async {
    setloading(true);
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
            SessionManager().userId = value.user!.uid.toString();
        setloading(false);
        Utils.toastMessage('User Login Successfully');
        Navigator.pushNamed(context, RouteName.dashboardScreen);
      });
    } on FirebaseAuthException catch (e) {
      setloading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
