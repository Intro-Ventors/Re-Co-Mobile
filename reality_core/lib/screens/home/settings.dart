import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: const Text("This Is the Settings page"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {},
        child: const Icon(Icons.add_to_photos_rounded),
      ),
    );
  }
}
//resolution
//vertual bg
//darkmode
//datasaver
