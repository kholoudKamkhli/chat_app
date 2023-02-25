
import 'package:chat_app/base.dart';
import 'package:chat_app/database/user_database.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/screens/create_account/create_account_connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountConnector>{

createAccount(String email,String password,String username)async {
  try {
    connector!.showLoading("loading");
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    MyUser user = MyUser(id: userCredential.user?.uid??"", username: username, email: email);
    await UserDatabase.addUserToDatabase(user);
    //connector!.hideDialog();
    connector!.showMessage("account created successfuly", "Ok");
    connector!.goToHome(user);
    return;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      connector!.hideDialog();
      connector!.showMessage("The password provided is too weak.", "Try again");
      //print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      connector!.hideDialog();
      connector!.showMessage("The account already exists for that email.", "Try again");
      print('The account already exists for that email.');
    }
  } catch (e) {
    connector!.hideDialog();
    connector!.showMessage(e.toString(), "Try again");
  }
}
}