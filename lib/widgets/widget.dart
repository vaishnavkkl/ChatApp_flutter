import 'package:flutter/material.dart';
Widget appBarMain(BuildContext context){
  return AppBar(

    title: Image.asset("asset/images/dot.jpg",height:40),
  );
}
InputDecoration textFieldInputDecoration( String hintText){
  return InputDecoration(hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54,fontFamily:'OpenSans'),
  //focusedBorder: UnderlineInputBorder(
     // borderSide:BorderSide(color:Colors.white),
   // enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color:Colors.white),)
    );
}
TextStyle simpleTextFieldStyle(){
  return TextStyle(
    color:Colors.white,fontSize: 16.0,
  );

}
TextStyle mediumTextStyle(){
  return TextStyle(color: Colors.white);
}