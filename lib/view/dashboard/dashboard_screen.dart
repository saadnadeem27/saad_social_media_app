import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:saad_social_media_app/view/dashboard/profile/profile_screen.dart';
import 'package:saad_social_media_app/view/dashboard/user/user_list_screen.dart';


import '../../res/color.dart';
import '../../utils/routes/routes.dart';
import 'home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final PersistentTabController controler =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      SafeArea(child: HomeScreen()),
      SafeArea(child: Text('Chat')),
      SafeArea(child: Text('Add')),
      SafeArea(child: UserListScreen()),
      SafeArea(child: ProfileScreen()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: Routes.generateRoute,
        ),
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: Routes.generateRoute,
        ),
        icon: Icon(Icons.chat),
        activeColorPrimary: AppColors.primaryIconColor,

        inactiveIcon: Icon(
          Icons.chat,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: Routes.generateRoute,
        ),
        icon: Icon(Icons.add),
        activeColorPrimary: AppColors.primaryIconColor,

        inactiveIcon: Icon(
          Icons.add_outlined,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: Routes.generateRoute,
        ),
        icon: Icon(Icons.groups),
        activeColorPrimary: AppColors.primaryIconColor,

        inactiveIcon: Icon(
          Icons. groups,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          onGenerateRoute: Routes.generateRoute,
        ),
        icon: Icon(Icons.person),
        activeColorPrimary: AppColors.primaryIconColor,

        inactiveIcon: Icon(
          Icons.person,
          color: Colors.grey.shade100,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      hideNavigationBar: false,
      screens: _buildScreens(),
      controller: controler,
      items: _navBarItems(),
      navBarStyle: NavBarStyle.style15,
      backgroundColor: AppColors.secondaryTextColor,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
    );
  }
}
