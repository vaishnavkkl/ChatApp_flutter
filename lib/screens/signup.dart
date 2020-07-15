import 'package:dotchat/model/helper.dart';
import 'package:dotchat/services/auth.dart';
import 'package:dotchat/services/database.dart';
import 'package:dotchat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'chatrooom.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading= false;
   AuthMethods authMethods= AuthMethods();
   DatabaseMethods databasemethods= new DatabaseMethods();
   HelperFunction helperfunction =HelperFunction();

  final formkey = GlobalKey<FormState>();
  TextEditingController usernameTextController=TextEditingController();
  TextEditingController emailTextController=TextEditingController();
  TextEditingController passwordTextController=TextEditingController();
  signMeUp(){
    if(formkey.currentState.validate()){
      Map<String,String> userInfoMap={
        'name':usernameTextController.text,
        'email':emailTextController.text
      };
      HelperFunction.saveuseremailsharedpreference(emailTextController.text);
      HelperFunction.saveusernamesharedpreference(usernameTextController.text);



      setState(() {
        isLoading= true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextController.text, passwordTextController.text).then((val){
        //print("${val.uid}");

        databasemethods.uploaduserinfo(userInfoMap);
        HelperFunction.saveuserloggedinsharedpreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -150,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children:[TextFormField(
                      validator: (val){
                        return val.isEmpty|| val.length<3?'Please provide Username':null;
                      },
                      controller: usernameTextController,
                      style: simpleTextFieldStyle(),
                      decoration: textFieldInputDecoration('Username'),
                    ),
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?null :'please provie a valid email id';
                        },
                        controller: emailTextController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration('email'),
                      ),
                      TextFormField(
                        obscureText:true,
                        validator: (val){
                          return val.length>6?null:'please provide password 6+ charachter';
                        }
                        ,
                        controller: passwordTextController,
                        style: simpleTextFieldStyle(),
                        decoration: textFieldInputDecoration('password'),
                      ),]
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
                  onTap: (){
                    signMeUp();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(color: Colors.white,
                      //gradient: LinearGradient(
                      //colors:[
                      //const Color(0xff007EF4),
                      //const Color(0xff2A75BC)]

                      // ),
                      borderRadius:BorderRadius.circular(30),
                    ),
                    child: Text('Sign Up',style:TextStyle(
                        color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                SizedBox(height: 18,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.white,

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
                      Text("Already  have an account?",style: mediumTextStyle(),),
                      GestureDetector(onTap: (){
                        widget.toggle();
                      },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Text('Sign in now',style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline
                          ),),
                        ),
                      )
                    ]
                ),
                SizedBox(height: 80.0,),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
