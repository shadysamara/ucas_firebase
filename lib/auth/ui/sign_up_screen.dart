import 'dart:developer';

import 'package:firebase_project/auth/models/register_request.dart';
import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/sign_in_screen.dart';
import 'package:firebase_project/auth/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController marketIdController = TextEditingController();
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

  nullValidation(String value) {
    if (value == null || value.isEmpty) {
      return 'required field';
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
      body: Consumer<AuthProvider>(
        builder: (context, controller, x) => Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RaisedButton(
                      child: Text('change_language'.tr()),
                      onPressed: () {
                        if (EasyLocalization.of(context).currentLocale ==
                            Locale('en')) {
                          EasyLocalization.of(context).setLocale(Locale('ar'));
                        } else {
                          EasyLocalization.of(context).setLocale(Locale('en'));
                        }
                      }),
                  Row(children: [
                    Expanded(
                        child: RadioListTile(
                      title: Text('customer'.tr()),
                      value: UserType.customer,
                      onChanged: (v) {
                        controller.selectUserType(v);
                      },
                      groupValue: controller.selectedUserType,
                    )),
                    Expanded(
                        child: RadioListTile(
                      title: Text('mershant'.tr()),
                      value: UserType.mershant,
                      onChanged: (v) {
                        controller.selectUserType(v);
                      },
                      groupValue: controller.selectedUserType,
                    ))
                  ]),
                  CustomTextField(
                      label: 'email'.tr(),
                      validation: validateEmail,
                      controller: emailController),
                  CustomTextField(
                      label: 'password'.tr(),
                      validation: validatePassword,
                      controller: passwordController),
                  CustomTextField(
                      label: 'confirm_password'.tr(),
                      validation: validateConfirmPassword,
                      controller: confirmPasswordController),
                  CustomTextField(
                      label: 'first_name'.tr(),
                      validation: nullValidation,
                      controller: firstNameController),
                  CustomTextField(
                      label: 'last_name'.tr(),
                      validation: nullValidation,
                      controller: lastNameController),
                  Visibility(
                      visible: controller.selectedUserType == UserType.mershant,
                      child: CustomTextField(
                          label: 'Market ID'.tr(),
                          validation: nullValidation,
                          controller: marketIdController)),
                  Row(children: [
                    Expanded(
                        child: RadioListTile(
                      title: Text('male'.tr()),
                      value: Gender.male,
                      onChanged: (v) {
                        controller.selectGender(v);
                      },
                      groupValue: controller.selectedGender,
                    )),
                    Expanded(
                        child: RadioListTile(
                      title: Text('female'.tr()),
                      value: Gender.female,
                      onChanged: (v) {
                        controller.selectGender(v);
                      },
                      groupValue: controller.selectedGender,
                    ))
                  ]),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return SignInScreen();
                        }));
                      },
                      child: Text('already_have_account'.tr())),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text('Register'.tr()),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          RegisterRequest registerRequest = RegisterRequest(
                              isMershant: controller.selectedUserType ==
                                  UserType.mershant,
                              fName: firstNameController.text,
                              lName: lastNameController.text,
                              email: emailController.text,
                              marketId: marketIdController.text,
                              password: passwordController.text,
                              gender: controller.selectedGender);
                          controller.createUser(registerRequest);
                        }
                      })
                ],
              ),
            )),
      ),
    );
  }
}
