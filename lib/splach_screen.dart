import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/home_screen.dart';
import 'package:firebase_project/auth/ui/main_page.dart';
import 'package:firebase_project/auth/ui/sign_in_screen.dart';
import 'package:firebase_project/auth/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<AuthProvider>(context, listen: false)
          .checkUser()
          .then((value) {
        if (value) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return MainPage();
          }));
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return SignInScreen();
          }));
        }
      });
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
