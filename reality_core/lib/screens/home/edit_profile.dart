import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reality_core/models/user.dart';
import 'package:reality_core/screens/auth/storage_methods.dart';
import 'package:reality_core/screens/auth/utils.dart';
import 'package:reality_core/screens/home/home.dart';
import 'package:reality_core/screens/home/settings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = const UserModel();
  bool showPassword = false;

  final fNameUpdateText = TextEditingController();
  final sNameUpdateText = TextEditingController();
  final emailUpdateText = TextEditingController();

  Uint8List? _image;

  var userData = {};
  bool isLoading = false;

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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fNameTextFeild = TextFormField(
        autofocus: false,
        controller: fNameUpdateText,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          fNameUpdateText.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.firstName}",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final sNameTextFeild = TextFormField(
        autofocus: false,
        controller: sNameUpdateText,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          sNameUpdateText.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.secondName}",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final emailTextFeild = TextFormField(
        autofocus: false,
        controller: emailUpdateText,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailUpdateText.text = value!;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "${loggedInUser.email}",
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                NetworkImage("${loggedInUser.profilePic}"),
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              fNameTextFeild,
              const SizedBox(height: 20),
              sNameTextFeild,
              const SizedBox(height: 20),
              emailTextFeild,
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    borderSide: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const Home()));
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      final docUser = FirebaseFirestore.instance
                          .collection("users")
                          .doc(loggedInUser.uid);
                      if (fNameUpdateText.text.isEmpty) {
                        fNameUpdateText.text = "${loggedInUser.firstName}";
                      } else {
                        docUser.update({"firstName": fNameUpdateText.text});
                        Fluttertoast.showToast(msg: "Profile Details Updated!");
                      }
                      if (sNameUpdateText.text.isEmpty) {
                        sNameUpdateText.text = "${loggedInUser.secondName}";
                      } else {
                        docUser.update({"secondName": sNameUpdateText.text});
                        Fluttertoast.showToast(msg: "Profile Details Updated!");
                      }
                      if (emailUpdateText.text.isEmpty) {
                        emailUpdateText.text = "${loggedInUser.email}";
                      } else {
                        docUser.update({"email": emailUpdateText.text});
                        Fluttertoast.showToast(msg: "Profile Details Updated!");
                      }
                      if (_image.toString() != loggedInUser.profilePic) {
                        String photoUrl = await StorageMethods()
                            .uploadImageToStorage(
                                'profilePics', _image!, false);

                        docUser.update({'profilePics': photoUrl});
                      }

                      setState(() {});

                      Fluttertoast.showToast(msg: "Profile Details Updated!");
                    },
                    color: Colors.cyan,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
