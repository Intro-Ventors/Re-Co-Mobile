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
  UserModel loggedInUser = UserModel();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
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
      );

  Widget buildDragHandle() => GestureDetector(
      child: Center(
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(18)),
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
            Text(
                "Welcome Back ${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
                            ))),
                  ),
                ],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
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
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            )),
      ),
    );
  }
}
