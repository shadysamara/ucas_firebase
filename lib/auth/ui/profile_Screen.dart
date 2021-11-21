import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .setEditPageFields();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfileScreen();
                }));
              },
              icon: Icon((Icons.edit)))
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  provider.uploadImageUrl();
                },
                child: provider.registerRequest.imageUrl == null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(provider.registerRequest.imageUrl),
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                title: Text('User Name'),
                subtitle: Text(provider.registerRequest.fName +
                    ' ' +
                    provider.registerRequest.lName),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(provider.registerRequest.email),
              ),
              ListTile(
                title: Text('Gender'),
                subtitle: Text(provider.registerRequest.gender == Gender.male
                    ? 'Male'
                    : 'Female'),
              ),
            ],
          );
        },
      ),
    );
  }
}
