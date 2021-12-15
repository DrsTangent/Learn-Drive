import 'package:application1/databaseConnection.dart';
import 'package:mysql1/mysql1.dart';

class User{
  static int _id = 0;
  static String _name = "";
  
  static Future<bool> setInfo(String username, String password) async
  {
      Results info = await MYSQL.query("SELECT idUser, name FROM User WHERE username LIKE '${username}' and password LIKE '${password}'");
      if(info.isNotEmpty)
      {
        print("Info Set");
          _id = info.first[0];
          _name = info.first[1];
          return true;
      }
      print("Info not set");

      return false;
  }

  static String get name => _name;
  static int get id => _id;
}