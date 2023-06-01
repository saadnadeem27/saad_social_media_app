import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';


import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../services/session_manager.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');
  bool _loading = false;
  
  bool get loading => _loading;

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(BuildContext context, String username, String email,
      String password) async {
    setloading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
            SessionManager().userId = value.user!.uid.toString();

        firestore.doc(value.user!.uid).set({
          'uid': value.user!.uid,
          'userName': username,
          'email': email,
          'phone': '',
          'onlineStatus': 'NoOne',
          'profile': '',
        }).then((value) {
          setloading(false);
          Navigator.pushNamed(context, RouteName.dashboardScreen);
        });

        setloading(false);
        Utils.toastMessage('User Created Successfully');
      });
    } on FirebaseAuthException catch (e) {
      setloading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
