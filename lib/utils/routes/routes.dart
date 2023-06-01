import 'package:flutter/material.dart';
import 'package:saad_social_media_app/utils/routes/route_name.dart';

import '../../view/dashboard/dashboard_screen.dart';
import '../../view/forgot_password/forgot_password_screen.dart';
import '../../view/login/login_screen.dart';
import '../../view/signup/sign_up_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
