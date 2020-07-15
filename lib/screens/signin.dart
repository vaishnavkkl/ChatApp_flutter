import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotchat/model/helper.dart';
import 'package:dotchat/screens/signinconstants.dart';
import 'package:dotchat/services/auth.dart';
import 'package:dotchat/services/database.dart';
import 'package:dotchat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'chatrooom.dart';

class SignIn1 extends StatefulWidget {
  final Function toggle;
  SignIn1(this.toggle);
  @override
  _SignIn1State createState() => _SignIn1State();
}

class _SignIn1State extends State<SignIn1> {
  AuthMethods authMethods =AuthMethods();
  DatabaseMethods databaseMethods= DatabaseMethods();
  final formKey=GlobalKey<FormState>();
  TextEditingController emailTextController=TextEditingController();
  TextEditingController passwordTextController=TextEditingController();
  bool isloading=false;
  QuerySnapshot snapshotUserinfo;
  signIn(){
    if(formKey.currentState.validate()){
      HelperFunction.saveuseremailsharedpreference(emailTextController.text);
     //

      setState(() {
        isloading = true;
      });
      databaseMethods.getUserbyEmail(emailTextController.text).then((val){
        snapshotUserinfo=val;
        HelperFunction.saveusernamesharedpreference(snapshotUserinfo.documents[0].data["name"]);

      });
      authMethods.signInWithEmailAndPassword(emailTextController.text, passwordTextController.text).then((val){
        if(val!=null){

          HelperFunction.saveuserloggedinsharedpreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
        }

      });



    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -150,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Form(
                key: formKey,
                child: Column(
                  children:[
                    Container( alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      height: 60.0,
                      child: TextFormField(
                        validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?null :'please provie a valid email id';
                      },
                        controller: emailTextController,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,fontFamily: 'OpenSans'
                        ),
                        decoration: textFieldInputDecoration('   Email'),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      height: 60.0,
                      child: TextFormField(obscureText:true,
                        validator: (val){
                          return val.length>6?null:'please provide password 6+ charachter';
                        },
                        controller: passwordTextController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration('  Password'),
                      ),
                    ),
                  ]
                ),
              ),
                SizedBox(height: 18,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:16,vertical: 8),
                    child: Text('forgot password ?',style: mediumTextStyle()),
                  ),
                ),
                SizedBox(height: 10,),

                GestureDetector(
                  onTap:(){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(color: Colors.blue,
                      //gradient: LinearGradient(
                        //colors:[
                          //const Color(0xff007EF4),
                           //const Color(0xff2A75BC)]

                     // ),
                      borderRadius:BorderRadius.circular(30),
                    ),
                    child: Text('Sign In',style:TextStyle(
                      color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                SizedBox(height: 18,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.blue,

                    borderRadius:BorderRadius.circular(30),
                  ),
                  child: Text('Sign in with Google',style:TextStyle(
                    color:Colors.black,fontSize: 20.0,fontWeight:FontWeight.w500,
                  ),),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:[
                    Text("Don't have account?",style: mediumTextStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(padding:EdgeInsets.symmetric(vertical: 3),
                        child: Text('Register now',style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline
                        ),),
                      ),
                    )
                  ]
                ),
                SizedBox(height: 80.0,)
              ],
            ),
          ),

        ),
      ),
    );
  }
}
