import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:saad_social_media_app/view/login/login_screen.dart';

import '../../../res/color.dart';
import '../../../res/components/round_button.dart';
import '../../../utils/routes/route_name.dart';
import '../../../utils/utils.dart';
import '../../../view_model/controller/profile_controller.dart';
import '../../../view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firestore = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    print(SessionManager().userId.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: StreamBuilder(
          stream: firestore.doc(SessionManager().userId.toString()).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print(snapshot.data.data()['userName'].toString());
              //Map map = snapshot.data.snapshot.value;

              //Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              // process data and return a widget
              // print(snapshot.data!.docs["userName"].toString());

              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ChangeNotifierProvider(
                    create: (_) => ProfileController(),
                    child: Consumer<ProfileController>(
                      builder: (context, provider, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.primaryButtonColor,
                                          width: 2),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: provider.image == null
                                            ? snapshot.data
                                                        .data()['profile']
                                                        .toString() ==
                                                    ''
                                                ? Icon(Icons.person)
                                                : Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      snapshot.data
                                                          .data()['profile']
                                                          .toString(),
                                                    ),
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Container(
                                                        child: Icon(Icons
                                                            .error_outline),
                                                      );
                                                    },
                                                  )
                                            //if file have an image then do this
                                            //:Container(),
                                            : Image.file(
                                                File(provider.image!.path)
                                                    .absolute)),
                                  ),
                                ),
                                //show the icon over stack

                                InkWell(
                                  onTap: () {
                                    provider.imagePicker(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        AppColors.primaryTextTextColor,
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.showUserNameDialogueAlert(
                                    context,
                                    snapshot.data
                                        .data()['userName']
                                        .toString());
                              },
                              child: ReusableRow(
                                icon: Icons.person_outline,
                                title: 'Username',
                                value:
                                    snapshot.data.data()['userName'].toString(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.showPhoneDialogueAlert(
                                    context, snapshot.data!.docs['phone']);
                              },
                              child: ReusableRow(
                                icon: Icons.phone_outlined,
                                title: 'Phone',
                                value: snapshot.data
                                            .data()['phone']
                                            .toString() ==
                                        ''
                                    ? 'xxx-xxx-xxx'
                                    : snapshot.data.data()['phone'].toString(),
                              ),
                            ),
                            ReusableRow(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: snapshot.data.data()['email'].toString(),
                            ),
                            ReusableRow(
                              icon: Icons.email_outlined,
                              title: 'Email',
                              value: snapshot.data.data()['email'].toString(),
                            ),
                            RoundButton(
                                title: 'Logout',
                                loading: provider.loading,
                                onTap: () {
                                  auth.signOut().then((value) {
                                    SessionManager().userId = '';

                                    Navigator.of(context, rootNavigator: true)
                                        .pushReplacementNamed(
                                            RouteName.loginScreen);
                                  });
                                })
                          ],
                        );
                      },
                    ),
                  ));
            } else {
              return Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.subtitle1,
              );
            }
          },
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ReusableRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: AppColors.primaryTextTextColor,
          ),
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),
          ),
          trailing: Text(
            value,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),
          ),
        ),
        const Divider(
          color: AppColors.dividedColor,
        ),
      ],
    );
  }
}
