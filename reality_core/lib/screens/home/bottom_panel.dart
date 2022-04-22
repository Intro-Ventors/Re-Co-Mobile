// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/home/edit_profile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  const PanelWidget(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = const UserModel();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromSnap(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20.0), right: Radius.circular(20.0)),
        child: Scaffold(
          backgroundColor: Colors.cyan,
          body: ListView(
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              buildDragHandle(),
              const SizedBox(
                height: 36,
              ),
              buildAboutText(),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      );

  Widget buildDragHandle() => GestureDetector(
      child: Center(
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(18)),
        ),
      ),
      onTap: togglePanel);

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  Widget buildAboutText() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                  "Welcome Back ${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  "${loggedInUser.profilePic}",
                ),
                radius: 60,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            buildTextField("First Name", "${loggedInUser.firstName}"),
            buildTextField("Last Name", "${loggedInUser.secondName}"),
            buildTextField("E-mail", "${loggedInUser.email}"),
            const SizedBox(
              height: 30,
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue[900],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                },
                child: const Text('Edit Profile'))
          ],
        ),
      );

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enableInteractiveSelection: false,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
  }
}
