class Message{
  static const String COLLECTION_NAME = "Message";
  String id;
  String content;
  String roomId;
  String senderName;
  int dateTime;
  String senderId;
  Message({
    this.id="",required this.content,required this.roomId,required this.dateTime,required this.senderId,required this.senderName
});
  Message.fromJson(Map<String,dynamic>json):this(
    id:json["id"],
    content:json["content"],
    roomId:json["roomId"],
    senderName:json["senderName"],
    dateTime:json["dateTime"],
    senderId:json["senderId"],

  );
  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "content":content,
      "roomId":roomId,
      "senderName":senderName,
      "dateTime":dateTime,
      "senderId":senderId,
    };
  }
}