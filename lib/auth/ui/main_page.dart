import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/auth/ui/home_screen.dart';
import 'package:firebase_project/auth/ui/profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [HomeScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: Consumer<AuthProvider>(
        builder: (context, provider, x) => BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: (int x) {
            pageController.jumpToPage(x);
            provider.changeindex(x);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), label: 'profile'.tr()),
          ],
        ),
      ),
    );
  }
}
