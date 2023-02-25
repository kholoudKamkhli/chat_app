import 'package:chat_app/base.dart';
import 'package:chat_app/providers/my_provider.dart';
import 'package:chat_app/screens/add_room/add_room_view.dart';
import 'package:chat_app/screens/home_screen/home_connector.dart';
import 'package:chat_app/screens/home_screen/home_view_model.dart';
import 'package:chat_app/screens/home_screen/room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeViewModel, HomeView>
    implements HomeConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    viewModel.readRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => viewModel,
        child: Stack(children: [
          const Image(
            image: AssetImage("assets/images/SIGN UP - PERSONAL.png"),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomView.routeName);
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Chat"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginView.routeName);
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: Consumer<HomeViewModel>(
              builder: (_, HomeViewModel, child) {
                return GridView.builder(
                    itemBuilder: (_, index) {
                      return RoomWidget(HomeViewModel.rooms[index]);
                    },
                    itemCount: HomeViewModel.rooms.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16));
              },
            ),
          ),
        ]));
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
