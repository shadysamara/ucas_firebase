import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/sign_in_screen.dart';
import 'package:firebase_project/auth/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  validateConfirmPassword(String password) {
    if (password == null || password.isEmpty) {
      return 'required field';
    } else if (password.length < 6) {
      return 'you must enter at least 6 characters';
    } else if (passwordController.text != confirmPasswordController.text) {
      return 'the passwords are not matched';
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
          key: formKey,
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
              CustomTextField(
                  label: 'Confirm Password',
                  validation: validateConfirmPassword,
                  controller: confirmPasswordController),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return SignInScreen();
                    }));
                  },
                  child: Text('already have account')),
              Spacer(),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('Register'),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .register(emailController.text,
                              passwordController.text, context);
                    }
                  })
            ],
          )),
    );
  }
}
