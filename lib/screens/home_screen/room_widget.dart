import 'package:flutter/material.dart';

import '../../models/room.dart';
import '../chat/chat_view.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatView.routeName,arguments: room);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        //height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              room.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/images/${room.catId}.png",
              height: 55,
            ),
            SizedBox(
              height: 10,
            ),
            Text(room.desc),
          ],
        ),
      ),
    );
  }
}
