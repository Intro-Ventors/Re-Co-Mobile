import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? uid;
  final String? profilePic;
  final String? firstName;
  final String? secondName;

  const UserModel(
      {this.firstName, this.secondName, this.uid, this.profilePic, this.email});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

// receiving data from server
    return UserModel(
      firstName: snapshot["firstName"],
      secondName: snapshot["secondName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
    );
  }

  // sending data to our server
  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "secondName": secondName,
        "uid": uid,
        "email": email,
        "profilePic": profilePic,
      };
}
