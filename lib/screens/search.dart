import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotchat/model/constants.dart';
import 'package:dotchat/model/helper.dart';
import 'package:dotchat/screens/conversation screen.dart';
import 'package:dotchat/services/database.dart';
import 'package:dotchat/widgets/widget.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
String _myname;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods =DatabaseMethods();
  TextEditingController searchTextController= TextEditingController();
  QuerySnapshot searchSnapshot ;
  Widget searchList(){
    return searchSnapshot !=null? ListView.builder(itemCount:searchSnapshot.documents.length,
        shrinkWrap:true,
        itemBuilder: (context,index){
          return SearchTile(
              userName: searchSnapshot.documents[index].data["name"],
              userEmail: searchSnapshot.documents[index].data["email"]
          );
        }):Container(


    );


  }

  initiateSearch(){
    databaseMethods.getUserbyUsername(searchTextController.text).then((val){
      setState(() {
        searchSnapshot=val;
      });
  });}
  createChatroomAndStartConversation({String userName} ){
   if(userName !=Constants.myname){
     String chatRoomId=getChatroomId(userName, Constants.myname);
     List<String> users=[userName,Constants.myname];
     Map<String, dynamic> chatRoomMap={
       "users":users,
       "chatroomid":chatRoomId
     };
     DatabaseMethods().createChatRoom(chatRoomId,chatRoomMap);
     Navigator.push(context, MaterialPageRoute(builder: (context)=>ConversationScreen(
       chatRoomId
     )));
   }else{
     print('user not found ');
   }
  }
Widget SearchTile({String userName,String userEmail}){
    return  Container(
      padding:EdgeInsets.symmetric(horizontal: 24,vertical:16),
      child: Row(
          children:[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(userName,style:simpleTextFieldStyle()),
                  Text(userEmail,style: simpleTextFieldStyle(),)
                ]
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                createChatroomAndStartConversation(
                  userName: userName
                );
              },
              child: Container(
                decoration:BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)
                )
                ,padding:EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text('Message',style:mediumTextStyle()),
              ),
            )

          ]
      ),
    );
}
@override
  void initState() {

    super.initState();
  }
  getUserinfo()async{
    _myname=await HelperFunction.getusernamesharedpreference();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarMain(context),
          body: Container(
            child: Column(
              children:[ Container(

                color: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                  children:[
                    Expanded(child: TextField(
                      controller:searchTextController,
                      style: TextStyle(color: Colors.white),
                      decoration:InputDecoration(
                        hintText: 'search Username',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        initiateSearch();
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
                      ),padding: EdgeInsets.all(4),child: Icon(Icons.search,color: Colors.white,size: 30,)),
                    )
                  ]
                ),
              ),
                searchList()
            ]),
          ),
    );
  }
}




getChatroomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";}

    else{
      return"$a\_$b";
    }

}