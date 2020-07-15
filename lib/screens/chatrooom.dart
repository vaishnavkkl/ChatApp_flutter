
import 'package:dotchat/model/constants.dart';
import 'package:dotchat/model/helper.dart';
import 'package:dotchat/screens/conversation%20screen.dart';
import 'package:dotchat/screens/search.dart';
import 'package:dotchat/services/database.dart';
import 'package:dotchat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:dotchat/services/auth.dart';
import 'package:dotchat/model/authenticate.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods= new AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(stream: chatRoomsStream,
    builder: (context,snapshot){
      return snapshot.hasData?ListView.builder(itemCount:snapshot.data.documents.length,itemBuilder: (context,index){
        return ClassRoomTile(snapshot.data.documents[index].data["chatroomid"].toString().replaceAll("_", "").replaceAll(Constants.myname, ""),
            snapshot.data.documents[index].data["chatroomid"] ) ;
      }):Container();
    },);
  }
  @override
  void initState() {
    getUserinfo();

    super.initState();
  }
  getUserinfo()async{
    Constants.myname=await HelperFunction.getusernamesharedpreference();
   setState(() {
     databaseMethods.getchatRooms(Constants.myname).then((value){
       setState(() {
         chatRoomsStream=value;

       });

     });

   });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("asset/images/dot.jpg",height: 50,),
        actions:[
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));

            },
            child: Container(
                padding:EdgeInsets.symmetric(horizontal:16),child: Icon(Icons.exit_to_app)),
          )]
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));}
      ),
    );
  }
}
class   ClassRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ClassRoomTile(this.userName,this.chatRoom);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(chatRoom)));
    },
      child: Container(
        color:Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical:16),
        child: Row(
          children:
            [
              Container(
                height: 40,width: 40,
                alignment: Alignment.center,
                decoration:BoxDecoration(
            color: Colors.blue,
                  borderRadius: BorderRadius.circular(40)
        ),
                child:Text("${userName.substring(0,1).toUpperCase()}",style: mediumTextStyle(),)
              ),
              SizedBox(width:8),
              Text(userName,style: mediumTextStyle(),)
            ]
        ),
      ),
    );
  }
}
