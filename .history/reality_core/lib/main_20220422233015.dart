import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reality_core/Graphics/engine.dart';

import 'package:page_transition/page_transition.dart';
import 'package:reality_core/screens/auth/sign_in.dart';

Future<ByteData> loadAsset(String asset) async {
  return await rootBundle.load(asset);
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}

/// Function to test the Vulkan Backend.
/// This is not permanent and is there just for debugging.
void testVulkanBackend() async {
  final engine =
      Engine(1280, 720, await loadAsset('assets/viking_room/texture.png'));
  final image = engine.getRenderData();
  engine.destroy();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // testVulkanBackend(); // JUST FOR DEBUGGING!
    // [Dhiraj] I removed the graphics engine for a bit, because there is a tiny
    // issue with the queues and stuff so until I debug it, I cant commit that
    // part. Everything else seems to be working fine and I got the validation
    // layers to work. Until the queue issue is resolved, keep this part commented.
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
