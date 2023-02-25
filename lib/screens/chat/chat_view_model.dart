import 'package:chat_app/database/RoomDatabase.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../base.dart';
import '../../models/my_user.dart';
import '../../models/room.dart';

class ChatViewModel extends BaseViewModel<BaseConnector> {
  late Room room;
  late MyUser myUser;
  void sendMessage(String content) {
    Message message = Message(content: content, roomId: room.id, dateTime: DateTime.now().millisecondsSinceEpoch, senderId: myUser.id, senderName: myUser.username);
    RoomDatabase.addMessageToDatabase(message);
  }
  Stream<QuerySnapshot<Message>>getMeesages(){
    return RoomDatabase.readRoomMesssages(room.id);
  }
}
