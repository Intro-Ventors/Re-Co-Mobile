// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

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
