import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../../res/color.dart';
import '../../res/components/input_text_field.dart';
import '../../utils/utils.dart';
import '../services/session_manager.dart';

/*
  1) First of all user pick image from source (gallery or camera)
  2) Then it will uploaded to firebase storage with its st_ref.putFile and make a URL
  3) Then the URL will be downloaded from st_ref.getDownloadUrl
  4) Then downloaded URL will be past in realtime database . (profile : newURL.toString())
  5) Then URL will be fetched into Image Widget i.e Network Image
*/
class ProfileController with ChangeNotifier {
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();

  final userNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  final auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

   final firestore = FirebaseFirestore.instance.collection('users');

  final storage = firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

//pick image from gallery
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
    notifyListeners();
  }

//pick image from camera
  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
    notifyListeners();
  }

//show dialgue when user press to add image
  void imagePicker(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 125,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.camera,
                      color: AppColors.primaryTextTextColor,
                    ),
                    title: Text(
                      'Camera',
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: AppColors.primaryTextTextColor,
                    ),
                    title: Text(
                      'Gallery',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//upload image into firebase storage then firebase storage gives
//url and then that url is pasted on realtime database in String

  void uploadImage(BuildContext context) async {
    setloading(true);

    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref(
      '/profileImage' + SessionManager().userId.toString(),
    );
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();

    firestore.doc(SessionManager().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      try {
        setloading(false);
        Utils.toastMessage('Profile updated');
        _image = null;
      } catch (e) {
        setloading(false);
        Utils.toastMessage(e.toString());
      }
    });
  }

//update username
  Future<void> showUserNameDialogueAlert(
      BuildContext context, String userName) async {
    userNameController.text = userName;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update UserName')),
            content: InputTextField(
                myController: userNameController,
                focusNode: userNameFocusNode,
                onFiledSubmittedValue: (value) {},
                onValidator: (value) {},
                keyboardType: TextInputType.text,
                hint: 'Enter UserName',
                obscureText: false),
            actions: [
              TextButton(
                onPressed: () {

                   firestore.doc(SessionManager().userId.toString()).update({
                    'userName':userNameController.text,
                  }).then((value){
                    userNameController.clear();
                  });
                  Navigator.pop(context);

                },
                child:
                    Text('Ok', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16)),
              ),
              TextButton(
                onPressed: () {

                 
                  Navigator.pop(context);

                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.alertColor,fontSize: 16 ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showPhoneDialogueAlert(
      BuildContext context, String phoneNumber) async {
    phoneController.text = phoneNumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update UserName')),
            content: InputTextField(
                myController: phoneController,
                focusNode: phoneFocusNode,
                onFiledSubmittedValue: (value) {},
                onValidator: (value) {},
                keyboardType: TextInputType.phone,
                hint: 'Enter Phone',
                obscureText: false),
            actions: [
              TextButton(
                onPressed: () {

                   firestore.doc(SessionManager().userId.toString()).update({
                    'phone':phoneController.text,
                  }).then((value){
                    phoneController.clear();
                  });
                  Navigator.pop(context);

                },
                child:
                    Text('Ok', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16)),
              ),
              TextButton(
                onPressed: () {

                 
                  Navigator.pop(context);

                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.alertColor,fontSize: 16 ),
                ),
              ),
            ],
          );
        });
  }
}
