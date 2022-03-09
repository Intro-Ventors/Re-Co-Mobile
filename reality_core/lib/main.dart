import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/Graphics/engine_bindings/engine.dart';
import 'package:reality_core/screens/auth/signIn.dart';
import 'package:page_transition/page_transition.dart';

/// Function to test the Vulkan Backend.
/// This is not permanent and is there just for debugging.
void testVulkanBackend() {
  final engine = Engine();
  engine.getRenderData();
  engine.destroy();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    testVulkanBackend(); // JUST FOR DEBUGGING!
  } catch (e) {
    print(e.toString());
  }

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re-Co',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/images/logo_icon.png',
        nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 200,
        duration: 3000,
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
