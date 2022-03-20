import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/auth/signIn.dart';
import 'package:reality_core/screens/home/home.dart';
import 'package:page_transition/page_transition.dart';

class AuthTree extends StatefulWidget {
  const AuthTree({Key? key}) : super(key: key);

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  User? user;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return AnimatedSplashScreen(
        splash: 'assets/images/logo_icon.png',
        nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 200,
        duration: 3000,
        backgroundColor: Colors.cyan,
      );
    }
    return const Home();
  }
}
