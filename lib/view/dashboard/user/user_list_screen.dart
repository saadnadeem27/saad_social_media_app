import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../res/color.dart';
import '../../../view_model/services/session_manager.dart';
import '../chat/message_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  //final ref = FirebaseDatabase.instance.ref().child('Users');
  final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Lists')),
      body: StreamBuilder(
          stream: firestore.snapshots(),
          builder: (context, snapshot) {
            // final profile = snapshot.data!.data()['profile'];
            // if (SessionManager().userId.toString() ==
            //     snapshot.data!.data()['uid'].toString()) {
            //   return Container();
            // } else {
            //   return
            //   //return card
            // }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                final profile =
                    snapshot.data!.docs[index]['profile'].toString();
                final email = snapshot.data!.docs[index]['email'].toString();
                final name = snapshot.data!.docs[index]['userName'].toString();
                final receiverId =
                    snapshot.data!.docs[index]['uid'].toString();
              if(SessionManager().userId.toString()==receiverId){
                return Container();
              }
              else{
                 return Card(
                  child: ListTile(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: MessageScreen(
                            email: email,
                            image: profile,
                            name: name,
                            receiverId: receiverId,
                          ),
                          withNavBar: false);
                    },
                    leading: profile == ''
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryTextTextColor,
                                    width: 2),
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person_outline,
                                  color: AppColors.primaryTextTextColor,
                                )),
                          )
                        : CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(profile),
                          ),
                    title: Text(
                      name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subtitle: Text(email,
                        style: Theme.of(context).textTheme.subtitle2),
                  ),
                );
              }


               
              });
            }
          }),
    );
  }
}
