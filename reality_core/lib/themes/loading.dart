import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reality_core/servises/auth.dart';

class LoadingAnimation extends StatelessWidget {
  LoadingAnimation({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: const Center(
        child: SpinKitSpinningLines(
          color: Colors.orange,
          size: 100.0,
        ),
      ),
    );
  }
}
