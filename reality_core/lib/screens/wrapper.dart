import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/auth/authenticate.dart';
import 'package:reality_core/screens/home/home.dart';
import 'package:page_transition/page_transition.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);
    print(user);

//returns the home or login depending on the auth status
    if (user == null) {
      return AnimatedSplashScreen(
        splash: 'assets/images/logo_icon.png',
        nextScreen: const Authenticate(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 200,
        duration: 3000,
        backgroundColor: Colors.cyan,
      );
    } else {
      return Home();
    }
  }
}
