import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/auth/utils.dart';
import 'package:reality_core/screens/home/bottom_panel.dart';
import 'package:reality_core/screens/home/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<Home> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            //Notification Widget?
          )
        ],
      ),
      drawer: DarwerMenu(),
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250,
                  child: Container(
                    height: 180.0,
                    width: 180.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QRScanner(),
                          ));
                        },
                        child: const Icon(Icons.power_settings_new_rounded,
                            size: 50),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Start Straming",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        controller: panelController,
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
          panelController: panelController,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        parallaxEnabled: true,
        parallaxOffset: 0.2,
      ),
    );
  }
}
