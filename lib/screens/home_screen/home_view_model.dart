import 'package:chat_app/base.dart';
import 'package:chat_app/database/RoomDatabase.dart';
import 'package:chat_app/screens/home_screen/home_connector.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeConnector>{
  List<Room> rooms = [];
   void readRooms()async{
     rooms = await RoomDatabase.getRooms();
   }
}