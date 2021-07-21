import 'package:flutter/cupertino.dart';

class AuthUser {
  final String username;
  final String password;

  AuthUser(this.username, this.password);

  factory AuthUser.fromMap(Map<String, dynamic> json) {
    return AuthUser(json['username'], json['password']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'password': this.password,
    };
    return newJSON;
  }
}

class UserApp extends ChangeNotifier {
  String username;
  String fullname;
  String description;
  String university;
  String school;
  String degree;
  String role;
  List<dynamic> subjectsDone;
  List<dynamic> subjectsRequested;
  String phone;
  String profilePhoto;
  List<dynamic> followers;
  List<dynamic> following;
  bool isGoogleAccount;

  void updateUser(UserApp user) {
    this.username = user.username;
    this.fullname = user.fullname;
    this.description = user.description;
    this.university = user.university;
    this.school = user.school;
    this.degree = user.degree;
    this.role = user.role;
    this.subjectsDone = user.subjectsDone;
    this.subjectsRequested = user.subjectsRequested;
    this.phone = user.phone;
    this.profilePhoto = user.profilePhoto;
    this.followers = user.followers;
    this.following = user.following;
    this.isGoogleAccount = user.isGoogleAccount;
    notifyListeners();
  }

  UserApp(
      this.username,
      this.fullname,
      this.description,
      this.university,
      this.school,
      this.degree,
      this.role,
      this.subjectsDone,
      this.subjectsRequested,
      this.phone,
      this.profilePhoto,
      this.followers,
      this.following,
      this.isGoogleAccount);

  factory UserApp.fromMap(Map<String, dynamic> json) {
    return UserApp(
        json['username'],
        json['fullname'],
        json['description'],
        json['university'],
        json['school'],
        json['degree'],
        json['role'],
        json['subjectsDone'],
        json['subjectsRequested'],
        json['phone'],
        json['profilePhoto'],
        json['followers'],
        json['following'],
        json['isGoogleAccount']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      'username': this.username,
      'fullname': this.fullname,
      'description': this.description,
      'university': this.university,
      'degree': this.degree,
      'school': this.school,
      'role': this.role,
      'subjectsDone': this.subjectsDone,
      'subjectsRequested': this.subjectsRequested,
      'phone': this.phone,
      'profilePhoto': this.profilePhoto,
      'followers': this.followers,
      'following': this.following,
      'isGoogleAccount': this.isGoogleAccount
    };
    return newJSON;
  }
}
