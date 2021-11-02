import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/home_screen.dart';
import 'package:firebase_project/auth/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      bool x = Provider.of<AuthProvider>(context, listen: false).checkUser();
      if (x) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return SignUpScreen();
        }));
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
