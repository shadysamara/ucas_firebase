import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .logOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: RaisedButton(onPressed: () {}),
      ),
    );
  }
}
