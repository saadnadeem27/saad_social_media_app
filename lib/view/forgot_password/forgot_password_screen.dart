import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../view_model/controller/forgot_password_controller.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  final emailFocusNode = FocusNode();
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(title: Text(''),
      elevation: 0,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'Forgot Password',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'Enter your email address \nto recover to your password',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * .06, bottom: height * .01),
                        child: Column(
                          children: [
                            InputTextField(
                                myController: emailController,
                                focusNode: emailFocusNode,
                                onFiledSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty ? 'Enter email' : null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                hint: 'Email',
                                obscureText: false),
                            SizedBox(
                              height: height * .01,
                            ),
                            
                          ],
                        ),
                      )),
                 
                  SizedBox(
                    height: height * .01,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => ForgotPasswordController(),
                    child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                          loading: provider.loading,
                          title: 'Recover',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.forgotPassword(
                                context,
                                emailController.text.toString(),
                                
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  
                ]),
          ),
        ),
      ),
    );
  }
}
