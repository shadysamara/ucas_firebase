import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/sign_up_screen.dart';
import 'package:firebase_project/auth/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignInScreen extends StatelessWidget {
  GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  validateEmail(String email) {
    if (email == null || email.isEmpty) {
      return 'required field';
    } else if (!isEmail(email)) {
      return 'incorrect email syntax';
    } else {
      return null;
    }
  }

  validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return 'required field';
    } else if (password.length < 6) {
      return 'you must enter at least 6 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Form(
          key: loginKey,
          child: Column(
            children: [
              CustomTextField(
                  label: 'Email',
                  validation: validateEmail,
                  controller: emailController),
              CustomTextField(
                  label: 'Password',
                  validation: validatePassword,
                  controller: passwordController),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return SignUpScreen();
                    }));
                  },
                  child: Text('create new account')),
              Spacer(),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('LOGIN'),
                  onPressed: () {
                    if (loginKey.currentState.validate()) {
                      Provider.of<AuthProvider>(context, listen: false).login(
                          emailController.text,
                          passwordController.text,
                          context);
                    }
                  })
            ],
          )),
    );
  }
}
