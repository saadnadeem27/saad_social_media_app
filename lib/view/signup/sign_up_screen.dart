import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_model/controller/signup_controller.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignupController(),
              child: Consumer<SignupController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          'Welcome to App',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          'Enter your email address \nto register to your account',
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
                                      myController: usernameController,
                                      focusNode: usernameFocusNode,
                                      onFiledSubmittedValue: (value) {
                                        Utils.fieldFocus(context,
                                            usernameFocusNode, emailFocusNode);
                                      },
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? 'Enter username'
                                            : null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      hint: 'Username',
                                      obscureText: false),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  InputTextField(
                                      myController: emailController,
                                      focusNode: emailFocusNode,
                                      onFiledSubmittedValue: (value) {},
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? 'Enter email'
                                            : null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      hint: 'Email',
                                      obscureText: false),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  InputTextField(
                                      myController: passwordController,
                                      focusNode: passwordFocusNode,
                                      onFiledSubmittedValue: (value) {},
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? 'Enter password'
                                            : null;
                                      },
                                      keyboardType: TextInputType.text,
                                      hint: 'Password',
                                      obscureText: true),
                                ],
                              ),
                            )),
                        RoundButton(
                          title: 'Sign Up',
                          loading: provider.loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.signup(
                                  context,
                                  usernameController.text.toString(),
                                  emailController.text.toString(),
                                  passwordController.text.toString());
                            }
                          },
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginScreen);
                          },
                          child: Text.rich(
                            TextSpan(
                                text: 'Already have an account ?',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ]),
                          ),
                        ),
                      ]),
                );
              }),
            )),
      ),
    );
  }
}
