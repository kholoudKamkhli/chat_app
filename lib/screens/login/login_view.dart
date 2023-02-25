import 'package:chat_app/base.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/screens/home_screen/home_view.dart';
import 'package:chat_app/screens/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/my_provider.dart';
import '../create_account/create_account_ui.dart';
import 'login_connector.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseView<LoginViewModel, LoginView>
    implements LoginConnector {
  var formKey = GlobalKey<FormState>();

  var emailCont = TextEditingController();

  var passwordCont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/SIGN UP - PERSONAL.png"),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Login"),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: emailCont,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return null;
                        } else {
                          return "Please enter valid Email";
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter Email",
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid Password";
                        } else
                          return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Enter Password",
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      loginAccount();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 53, 152, 219),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, CreateAccount.routeName);
                      },
                      child: const Text("Don't Have An Account ? Register")),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  void loginAccount() {
    viewModel.loginAccount(emailCont.text, passwordCont.text);
  }

  @override
  goToHome(MyUser user) {
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeView.routeName);
  }
}
