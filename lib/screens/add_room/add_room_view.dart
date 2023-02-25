import 'package:chat_app/base.dart';
import 'package:chat_app/models/category.dart';
import 'package:chat_app/screens/add_room/add_room_connector.dart';
import 'package:chat_app/screens/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddRoomView extends StatefulWidget {
  static const String routeName = "addRoom";

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends BaseView<AddRoomViewModel, AddRoomView>
    implements AddRoomConnector {
  var formKey = GlobalKey<FormState>();

  var titleCont = TextEditingController();

  var descCont = TextEditingController();
  var rooms = Category.getCategories();
  var selectedRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    selectedRoom = rooms[0];
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
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              centerTitle: true,
              title: const Text("Add New Room"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: true,
              // leading: BackButton(
              //   onPressed: (){
              //     Navigator.pop(context);
              //   },
              // ),
            ),
            body: Form(
              key: formKey,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                elevation: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "Create New Room",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
    padding: EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset("assets/images/group-1824146_1280.png")),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: titleCont,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          } else {
                            return "Room Title Can't Be Empty";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Enter Room Title",
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
                      height: 13,
                    ),
                    DropdownButton(
                        value: selectedRoom,
                        items: rooms
                            .map((room) => DropdownMenuItem<Category>(
                                value: room,
                                child: Row(
                                  children: [
                                    Image.asset(room.image,height: 30,width: 30,),
                                    SizedBox(width: 4,),
                                    Text(room.name),
                                  ],
                                )))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          } else {
                            setState(() {
                              selectedRoom = value;
                            });
                          }
                        }),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(

                        controller: descCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Room Description Can't Be Empty";
                          } else
                            return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Enter Room Description",
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
                        validateForm();
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
                          "Add Room",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.addRoomToDB(titleCont.text, descCont.text, selectedRoom.name);
    }
  }

  @override
  void roomCreated() {
    Navigator.pop(context);
  }
}
