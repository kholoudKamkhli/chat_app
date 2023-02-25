import 'package:chat_app/base.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/providers/my_provider.dart';
import 'package:chat_app/screens/chat/chat_connector.dart';
import 'package:chat_app/screens/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/room.dart';
import 'chat_view_model.dart';

class ChatView extends StatefulWidget {
  static const String routeName = "ChatView";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseView<ChatViewModel, ChatView>
    implements ChatConnector {
  var messageCont = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    viewModel.room = room;
    var provider = Provider.of<MyProvider>(context);
    viewModel.myUser = provider.user!;
    return ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Stack(children: [
          const Image(
            image: AssetImage("assets/images/SIGN UP - PERSONAL.png"),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(room.title),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
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
                child: Column(
                  children: [
                    Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: viewModel.getMeesages(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else if(snapshot.hasError){
                          return Center(child: Text("Something went wrong"),);
                        }
                        var messages = snapshot.data!.docs.map((e)=>e.data()).toList();
                        return ListView.builder(itemBuilder: (buildContext,index){
                          if(index==0){
                            return MessageWidget(messages[index]);
                          }
                          else
                          return MessageWidget(messages[index],prevMessage:messages[index-1] ,);
                        },itemCount: messages.length??0,);
                      },
                    )),
                    Row(children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                          child: TextFormField(
                            controller: messageCont,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              prefix: SizedBox(width: 7,),
                              hintText: "Type A Message...",
                              // fillColor: Colors.black12,
                              // filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black12), //<-- SEE HERE
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.black12), //<-- SEE HERE
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: InkWell(
                          onTap: (){
                            if(messageCont.text!=null&&messageCont.text!=""){
                              viewModel.sendMessage(messageCont.text);
                              messageCont.clear();
                            }
                          },
                          child:
                              Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 28,
                              ),

                        ),
                      )
                    ]),
                  ],
                )),
          ),
        ]));
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }
}
