import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes/route_name.dart';
import '../../../view_model/services/session_manager.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SessionManager().userId.toString(),
        ),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              SessionManager().userId='';
              Navigator.pushNamed(context, RouteName.loginScreen);
            });
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
       
      ]),
    );
  }
}
