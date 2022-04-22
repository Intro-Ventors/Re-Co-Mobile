import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reality_core/Graphics/engine.dart';
import 'package:reality_core/providers/user_provider.dart';
import 'package:reality_core/screens/home/home.dart';
import 'package:reality_core/themes/splash_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reality Core',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.blue[900],
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const Home();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
