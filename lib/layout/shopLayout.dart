import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/loginScreen.dart';
import 'package:shopapp/modules/onBording/onBoardingScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cacheHelper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            CacheHelper.removeData(key: 'token').then((value) {
              if (value) {
                navigateAndFinish(
                  context,
                  LoginScreen(),
                  // OnBordingScreen(),
                );
              }
            });
          },
          child: Text(
            "Logout",
          ),
        ),
      ),
    );
  }
}
