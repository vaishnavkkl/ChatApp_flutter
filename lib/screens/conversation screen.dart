import 'package:dotchat/model/constants.dart';
import 'package:dotchat/services/database.dart';
import 'package:dotchat/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
DatabaseMethods databaseMethods=DatabaseMethods();
TextEditingController messageController=TextEditingController();
Stream chatMessageStream;
  Widget ChatMessageList(){
    return StreamBuilder(stream: chatMessageStream,
    builder: (context,snapshot){
      return snapshot.hasData?ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (context,index){
        return MessageTile(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sendby"]==Constants.myname);
      }):Container();

    },);


  }
  sendMessage(){
    if(messageController.text.isNotEmpty){
    Map<String,dynamic > messageMap ={
      "message":messageController.text,
      "sendby":Constants.myname,
      "time":DateTime.now().millisecondsSinceEpoch
    };
    databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    messageController.text="";
  }}
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
     setState(() {
       chatMessageStream=value;
     });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children:[
            ChatMessageList(),
            Container(

              alignment:Alignment.bottomCenter,

              child: Container(

                color: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                    children:[
                      Expanded(child: TextField(
                        controller:messageController,
                        style: TextStyle(color: Colors.white),
                        decoration:InputDecoration(
                            hintText: 'Message_',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                         sendMessage();
                        },


                        child: Container(
                            height:40,width: 40,decoration:BoxDecoration(
                            gradient: LinearGradient(
                                colors:[
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(40)
                        ),padding: EdgeInsets.all(4),child: Icon(Icons.message,color: Colors.white,size: 25,)),
                      )
                    ]
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
class MessageTile extends StatelessWidget {
  final String message;
  final bool issendbyme;
  MessageTile(this.message,this.issendbyme);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:issendbyme?0:25,right: issendbyme?24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width:MediaQuery.of(context).size.width,
      alignment:issendbyme?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:25,vertical:8),
        decoration:BoxDecoration(
          gradient: LinearGradient(
            colors: issendbyme?[
              const Color(0xff007EF4),
              const Color(0xff2A75BC)]:[
                const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)

            ]
          ),
          borderRadius: issendbyme?BorderRadius.only(topLeft: Radius.circular(24),
          topRight:Radius.circular(24),bottomLeft:Radius.circular(24)):BorderRadius.only(topLeft: Radius.circular(24),
              topRight:Radius.circular(24),bottomRight:Radius.circular(24))
        ),
       child: Text(message,style: TextStyle(),),
      ),
    );
  }
}
