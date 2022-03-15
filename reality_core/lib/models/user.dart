class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? picURL;
  // bool isDarkMode = false;

  UserModel(
      {this.uid, this.email, this.firstName, this.secondName, this.picURL});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        picURL: map['profilePic']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'profilePic': picURL,
    };
  }
}
