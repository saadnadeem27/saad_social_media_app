import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../res/color.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services/session_manager.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final String image;
  final String email;
  final String receiverId;

  const MessageScreen(
      {super.key,
      required this.email,
      required this.image,
      required this.receiverId,
      required this.name});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final firestore = FirebaseFirestore.instance.collection('users');
  final messageController = TextEditingController();
  messageSend(){
    final timeStamp=DateTime.now().millisecondsSinceEpoch.toString();
    if(messageController.text.isEmpty){
      Utils.toastMessage('Enter Message');
    }
    else{
      firestore.doc(timeStamp).set({
        'isSeen':false,
        'message':messageController.text.toString(),
        'sender':SessionManager().userId.toString(),
        'receiver':widget.receiverId,
        'type':'text',
        'time':timeStamp.toString(),
      }).then((value){
        messageController.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toString())),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Text(index.toString());
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: TextFormField(  
                        showCursor: true,
                        controller: messageController,
                        cursorColor: AppColors.primaryTextTextColor,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(height: 0, fontSize: 19),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: (){
                              messageSend();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryButtonColor,
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          hintText: 'Enter Message',
                          contentPadding: EdgeInsets.all(15),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  height: 0,
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.50)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.textFieldDefaultFocus),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.secondaryColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.textFieldDefaultBorderColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.alertColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
