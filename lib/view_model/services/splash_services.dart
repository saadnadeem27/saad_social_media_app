import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saad_social_media_app/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';


class SplashServices {
  void isLogin(context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionManager().userId= user.uid.toString();
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamed(context, RouteName.dashboardScreen),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamed(context, RouteName.loginScreen),
      );
    }
  }
}
