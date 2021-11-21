import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Page'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).editProfile();
              },
              icon: Icon((Icons.done)))
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    provider.uploadImageUrl();
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: provider.pickedFile != null
                        ? FileImage(provider.pickedFile)
                        : NetworkImage(provider.registerRequest.imageUrl ??
                            'https://st2.depositphotos.com/1104517/11967/v/950/depositphotos_119675554-stock-illustration-male-avatar-profile-picture-vector.jpg'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  title: Text('First Name'),
                  subtitle: TextField(
                    controller: provider.firstNameController,
                  ),
                ),
                ListTile(
                  title: Text('Last Name'),
                  subtitle: TextField(
                    controller: provider.lastNameController,
                  ),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(provider.registerRequest.email),
                ),
                ListTile(
                  title: Text('Gender'),
                  subtitle: Row(children: [
                    Expanded(
                        child: RadioListTile(
                      title: Text('male'.tr()),
                      value: Gender.male,
                      onChanged: (v) {
                        provider.selectGender(v);
                      },
                      groupValue: provider.selectedGender,
                    )),
                    Expanded(
                        child: RadioListTile(
                      title: Text('female'.tr()),
                      value: Gender.female,
                      onChanged: (v) {
                        provider.selectGender(v);
                      },
                      groupValue: provider.selectedGender,
                    ))
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
