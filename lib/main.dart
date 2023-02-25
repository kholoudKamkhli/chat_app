import 'package:chat_app/providers/my_provider.dart';
import 'package:chat_app/screens/add_room/add_room_view.dart';
import 'package:chat_app/screens/chat/chat_view.dart';
import 'package:chat_app/screens/create_account/create_account_ui.dart';
import 'package:chat_app/screens/home_screen/home_view.dart';
import 'package:chat_app/screens/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ChangeNotifierProvider(
    create: (cotext)=>MyProvider(),
      child: MyApp()));
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      title: 'Chat App',
      routes: {
        CreateAccount.routeName:(_)=>CreateAccount(),
        LoginView.routeName:(_)=>LoginView(),
        HomeView.routeName:(_)=>HomeView(),
        AddRoomView.routeName:(_)=>AddRoomView(),
        ChatView.routeName:(_)=>ChatView(),
      },
      initialRoute:provider.firebaseUser!=null?HomeView.routeName:LoginView.routeName ,
    );
  }
}

