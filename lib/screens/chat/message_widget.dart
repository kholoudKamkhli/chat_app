import 'package:chat_app/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  Message? prevMessage;
  MessageWidget(this.message,{this.prevMessage});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return provider.user!.id==message.senderId?SenderMessage(message):RecieverMessage(message);
  }
}

class RecieverMessage extends StatelessWidget {
  Message message;
  Message? prevMessage;
  RecieverMessage(this.message,{this.prevMessage});
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    String formattedDate = DateFormat('HH:mm').format(date);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          prevMessage?.senderName!=message.senderName?Text(message.senderName,textAlign: TextAlign.start,style: TextStyle(
              color: Colors.grey
          ),):SizedBox(height: 0,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical:7),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight:Radius.circular(18) ,
                bottomRight:Radius.circular(18) ,
              ),
            ),
            child: Text(message.content,style: TextStyle(
              color: Colors.white,
            ),textAlign: TextAlign.end,),
          ),
          SizedBox(height:7),
          Text(formattedDate,textAlign: TextAlign.end,style: TextStyle(
              color: Colors.grey
          ),),
        ],
      ),
    );
  }
}
class SenderMessage extends StatelessWidget {

  Message message;
  Message? prevMessage;
  SenderMessage(this.message,{this.prevMessage});
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(message.dateTime);
    String formattedDate = DateFormat('HH:mm').format(date);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: prevMessage?.senderName!=message.senderName?Text(message.senderName,textAlign: TextAlign.start,style: TextStyle(
          //       color: Colors.grey
          //   ),):SizedBox(height:0),
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical:7),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight:Radius.circular(18) ,
                bottomLeft:Radius.circular(18) ,
              ),
            ),
            child: Text(message.content,style: TextStyle(
              color: Colors.white,
            ),),
          ),
          SizedBox(height:7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(formattedDate,textAlign: TextAlign.start,style: TextStyle(
                color: Colors.grey
            ),),
          ),
        ],
      ),
    );
  }
}

