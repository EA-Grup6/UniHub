import 'package:flutter/material.dart';
import 'package:unihub_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApp _userFromFirebaseUser(User user){
    return user != null ? UserApp(user.uid, user.uid, user.uid, user.uid, user.uid) : null;
  }

Future registerWithEmailAndPassword(String email, String password) async{
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e){
    print(e.toString());
    return null;
  }
}
}