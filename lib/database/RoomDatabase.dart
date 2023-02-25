import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import '../models/room.dart';

class RoomDatabase {
  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Room.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Message.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addRoomToDatabase(Room room) {
    var collection = getRoomsCollection();
    var docref = collection.doc();
    room.id = docref.id;
    return docref.set(room);
  }
  static Future<void> addMessageToDatabase(Message message) {
    var docref = getMessagesCollection(message.roomId).doc();
    message.id = docref.id;
    return docref.set(message);
  }
  static Stream<QuerySnapshot<Message>> readRoomMesssages(String roomId){
    return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
  }

  static Future<List<Room>> getRooms() async {
    QuerySnapshot<Room> room = await getRoomsCollection().get();
    return room.docs.map((room) => room.data()).toList();
  }
}
