import 'package:chat_app/database/user_database.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  MyUser ?user;
  User?firebaseUser;
  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initMyUser();
    }

  }
  void initMyUser() async {
    user = await UserDatabase.getUser(firebaseUser?.uid??"");
  }
}