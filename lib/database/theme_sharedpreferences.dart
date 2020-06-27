
import 'package:Dont_Forgot/interfaces/sharedpreferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalStorage implements ISharedPreference {
  @override
  Future delete(String key) async {
      var shared = await SharedPreferences.getInstance();
      return shared.remove(key);
    }
  
    @override
    Future get(String key) async {
      var shared = await SharedPreferences.getInstance();
      return shared.get(key);
    }
  
    @override
    Future put(String key, dynamic value) async {
      var shared = await SharedPreferences.getInstance();
      if(value is bool){
        shared.setBool(key, value);
      } else if (value is String){
        shared.setString(key, value);
      } else if (value is int){
        shared.setInt(key, value);
      } else{
        shared.setDouble(key, value);
      }
  }
}