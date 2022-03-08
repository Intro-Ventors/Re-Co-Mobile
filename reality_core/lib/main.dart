import 'dart:ffi';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:vulkan_backend/vulkan_backend.dart';
import 'package:reality_core/screens/auth/signIn.dart';
import 'package:page_transition/page_transition.dart';

/// Function to test the Vulkan Backend.
/// This is not permanent and is there just for debugging.
void testVulkanBackend() {
  //Instance instance = Instance(true);
  //final device = instance.createDevice();

  //device.destroy();
  //instance.destroy();

  final DynamicLibrary nativeAddLib = Platform.isAndroid
      ? DynamicLibrary.open('libgraphics_engine.so')
      : DynamicLibrary.process();

  final int Function(int x, int y) nativeAdd = nativeAddLib
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
      .asFunction();

  int result = nativeAdd(10, 20);
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
