import'package:shared_preferences/shared_preferences.dart';
    class HelperFunction{
  static String sharedpreferenceuserloggedinkey="ISLOGEDIN:";
  static String sharedpreferenceusernamekey="USERNAMEKEY";
  static String sharedpreferenceemailkey="USEREMAILKEY";
  //saving data in shared prefernce
    static Future<bool> saveuserloggedinsharedpreference(bool isUserLoggedIn)async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      return await prefs.setBool(sharedpreferenceuserloggedinkey, isUserLoggedIn);
    }
  static Future<bool> saveusernamesharedpreference(String userName)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceusernamekey, userName);
  }
  static Future<bool> saveuseremailsharedpreference(String userEmail)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceemailkey, userEmail);
  }
  //getting the data in shared preference
  static Future<bool> getloggedinsharedpreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getBool(sharedpreferenceuserloggedinkey, );
  }

  static Future<String> getusernamesharedpreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getString(sharedpreferenceusernamekey);
  }
  static Future<String> getuseremailsharedpreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return  prefs.getString(sharedpreferenceusernamekey);
  }

    }