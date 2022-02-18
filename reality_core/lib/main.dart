import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/wrapper.dart';
import 'package:reality_core/servises/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
        value: AuthService().user,
        initialData: null,
        child: const MaterialApp(home: Wrapper()));
  }
}
