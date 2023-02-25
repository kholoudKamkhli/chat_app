import 'package:chat_app/base.dart';
import 'package:chat_app/database/user_database.dart';
import 'package:chat_app/screens/login/login_connector.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/my_user.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  String message = "";

  loginAccount(String email, String password) async {
    try {
      connector!.showLoading("loading");
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "Logged in successfuly";
      MyUser? user = await UserDatabase.getUser(userCredential.user?.uid ?? "");
      if (user != null) {
        connector!.hideDialog();
        connector!.goToHome(user);
        return;
      }
    } on FirebaseAuthException catch (e) {
      message = "wrong email or password";
    } catch (e) {
      message = "error occured $e";
    }
    if (message != "") {
      connector!.hideDialog();
      connector!.showMessage(message, "Okay");
    }
  }
}
