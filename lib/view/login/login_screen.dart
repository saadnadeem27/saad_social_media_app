import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';


import '../../res/color.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
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
                    'Welcome to App',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'Enter your email address \nto connect to your account',
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.forgotPasswordScreen);
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginController(),
                    child: Consumer<LoginController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                          loading: provider.loading,
                          title: 'Login',
                          
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              provider.login(
                                context,
                                emailController.text.toString(),
                                passwordController.text.toString(),
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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.signupScreen);
                    },
                    child: Text.rich(
                      TextSpan(
                          text: 'Don\'t have an account ?',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 15),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline),
                            ),
                          ]),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
