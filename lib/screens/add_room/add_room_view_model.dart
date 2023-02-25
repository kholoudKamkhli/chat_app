

import 'package:chat_app/base.dart';
import 'package:chat_app/database/RoomDatabase.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/screens/add_room/add_room_connector.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomConnector>{
  Future<void> addRoomToDB(String title , String desc , String catId) async {
    var room = new Room(title: title, desc: desc, catId: catId);
    await RoomDatabase.addRoomToDatabase(room).then((value) {
      connector!.showMessage("room added successfully", "okay",posAction: (){
        connector!.roomCreated();
      });
    }).catchError((e){
      connector!.showMessage("error occured", "close");
    });
  }
}